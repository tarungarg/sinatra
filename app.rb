require 'rubygems'
require "byebug"
require 'bcrypt'
require 'sinatra'
require 'sinatra/activerecord'
require 'json'

class Product < ActiveRecord::Base
end

class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end

get "/" do
  @user = User.new
  erb :"users/new"
end

post "/users" do
end

post "/signup" do
  byebug
  @user = User.new(params[:user])
  if @user.save
    json :"products/index"
  else
    json :"/users/new"
  end
end

get "/products" do
  @products = Product.order("created_at DESC")
  @title = "Welcome."
  erb :"products/index"
end
