require 'rubygems'
require "byebug" # debug applicaion
require 'bcrypt' # encrypt password
require 'sinatra'
require 'sinatra/flash' # flash messages
require 'sinatra/activerecord'
require 'json'
require 'braintree' # for payments

Dir[File.dirname(__FILE__) + '/models/*.rb'].each {|file| require file }

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each {|file| require file }
include BraintreeTransaction

require File.expand_path('../config/braintree_config.rb', __FILE__)

enable :sessions

set :environment, :development

# check if user is logged in
register do
  def auth (type)
    condition do
      redirect "/" unless send("is_#{type}?")
    end
  end
end

helpers do
  def is_user?
    @current_user != nil
  end
end

# filter to check current user
before do
  @current_user = User.find_by_id(session[:user_id])
end

## Routes

# root url for sign in
get "/" do
  @current_user = User.find_by_id(session[:user_id])
  if @current_user
    redirect "/products"
  else
    erb :"users/login"
  end
end

# view registration page
get "/signup" do
  @user = User.new
  erb :"/users/new"
end

# register new user
post "/create_signup" do
  # validaiton for mass assignment check
  @user = User.new(params[:user]) if params[:user].has_key?("email") && params[:user].has_key?("password") && params[:user].has_key?("password_confirmation") && params[:user].has_key?("firstname") && params[:user].has_key?("lastname") 
  if @user && @user.save
    session[:user_id] = @user.id
    halt 200, {email: @user.email}.to_json
  else
    halt 400, {errors: @user.errors.full_messages }.to_json
  end
end

# sign in page
get "/sign_in" do
  @current_user = User.find_by_id(session[:user_id])
  if @current_user
    session[:user_id] = @user.id
    redirect "/products"
  else
    erb :"users/login"
  end
end

# Check if user is valid
post "/create_sign_in" do
  user = User.authenticate(params[:user][:email], params[:user][:password]) if params[:user].has_key?("email") && params[:user].has_key?("password")
  if user
    session[:user_id] = user.id
    halt 200, {email: user.email}.to_json
  else
    halt 400, {error: "Invalid Username and password" }.to_json
  end
end

delete "/destroy_user" do
  session[:user_id] = nil
  flash[:error] = "Logged Out!!"
  redirect "/"
end

## Product code

# list of prducts
get "/products", :auth => :user do
  @products = Product.order("created_at DESC")
  erb :"products/index.html"
end

get "/new_product", :auth => :user do
  erb :"products/new"
end

post "/add_product" do
  # validaiton for mass assignment
  params[:product]["status"] = params[:product]["status"] == "on" ? 1 : 0
  @product = Product.new(params[:product]) if params[:product].has_key?("name") && params[:product].has_key?("status") && params[:product].has_key?("description")&& params[:product].has_key?("price")
  if @product && @product.save
    halt 200, {message: "Product Created"}.to_json
  else
    halt 400, {errors: @product.errors.full_messages }.to_json
  end
end

get "/edit_product/:id", :auth => :user do
  @product = Product.find_by_id(params[:id]) if params[:id]
  if @product
    erb :"products/edit"
  else
    redirect :"/products"
  end
end

# update product
put "/update_product/:id" do
  @product = Product.find_by_id(params[:id]) if params[:id]
  params[:product]["status"] = params[:product]["status"] == "on" ? 1 : 0
  update_succ = @product.update(params[:product]) if @product && params[:product].has_key?("name") && params[:product].has_key?("status") && params[:product].has_key?("description")&& params[:product].has_key?("price")
  if update_succ
    halt 200, {message: "Product Updated"}.to_json
  else
    halt 400, {errors: @product.errors.full_messages }.to_json
  end
end

## Add to cart functionality

# create order
get "/add_to_cart", :auth => :user do
  @product = Product.find_by_id(params[:product_id])
  @order = OrderLine.where(["product_id = ? && customer_id = ? && order_id IS NULL", params[:product_id].to_i, @current_user.id ])
  unless @order.blank?
    @order[0].qty = @order[0].qty + 1
    @order[0].total_price = @order[0].total_price + @product.price
    if @order[0].save
      halt 200, {order: @order[0]}.to_json
    else
      halt 400, {errors: @order[0].errors.full_messages }.to_json
    end
  else
    @order = OrderLine.new
    @order.product_id = @product.id
    @order.unit_price = @product.price
    @order.customer_id = @current_user.id
    @order.total_price = @product.price
    @order.qty = 1
    if @order.save
      halt 200, {order: @order}.to_json
    else
      halt 400, {errors: @order.errors.full_messages }.to_json
    end
  end
end

## Orders of products

# remove redundency of code and check if the user is log in
before "/*" do
  if params[:splat] == ["order_list"] || params[:splat] == ["checkout_order"] || params[:splat] == ["create_transaction"] && @current_user
    @orderlines = OrderLine.includes(:product).order("updated_at DESC").where(["customer_id = ? && order_id IS NULL", @current_user.id ])
    @total_price = @orderlines.map(&:total_price).sum unless @orderlines.blank?
  end
end

# order list
get "/order_list", :auth => :user do
  erb :"/orders/index"
end

# credit card detail page
get "/checkout_order", :auth => :user do
  erb :"/orders/braintree"
end

# connect with brain tree for payment
post "/create_transaction" do
  amount_pay = @total_price.to_f - @total_price.to_f*0.1 if @total_price
  result = transction(params, amount_pay) # transaction logic move to lib
  # if transaction is succed
  if result.success?
    order = Order.new
    order.customer_id = @current_user.id
    order.total = amount_pay
    order.date = Date.today
    # add uniq order no.
    if Order.count == 0
      order.order_no = "O01"
    else
      ord = Order.last
      order.order_no = "O0" + (ord.order_no.scan(/\d/).join('').to_i + 1).to_s
    end
    # update the order lines whoes payment has been successful.
    if order.save
      @current_user.order_lines.where("order_id is null").each do |ol|
        ol.order_id = order.id
        ol.save
      end
      halt 200, {message: "Success! Transaction ID: #{result.transaction.id}"}.to_json
    else
      halt 400, {error: order.errors.full_messages}.to_json
    end
  else
    halt 400, {errors: "Error: #{result.message}" }.to_json
  end
end

# get order history
get "/order_history", :auth => :user do
  # include for eggar load
  @orders = @current_user.orders.order("created_at DESC").includes(:order_lines, {order_lines: :product})
  erb :"/orders/order_history"
end
