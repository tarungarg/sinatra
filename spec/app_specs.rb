require File.expand_path '../spec_helper.rb', __FILE__
require "byebug"


describe 'get request for sign in and sign up' do
  
  it "should sign in" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to match('<h1>Sign In</h1>')
  end

  it "should rediect to sign in page if aready sign in" do
    @user = FactoryGirl.create(:user)
    @params = {email: @user.email, 
                password: @user.password}
    post "/create_sign_in", {user: @params}
    get '/'
    last_response.should be_redirect
    last_response.location.should include '/products'
  end

  it "should sign up" do
    get '/signup'
    expect(last_response).to be_ok
    expect(last_response.body).to match('FirstName:')
  end
end

describe 'post call for register the new user' do
  it "should register new user" do
    @params = {firstname: "tarun", lastname: "garg", email: "tarungarg402@gmail.com", 
                password: "1234567", password_confirmation: "1234567"}
    post "/create_signup", {user: @params}
    last_response.status.should eq 200
  end

  it "should register new user" do
    @params = {firstname: "tarun", lastname: "garg", email: "tarungarg402@gmail.com", 
                password: "1234567", password_confirmation: "1234567"}
    post "/create_signup", {user: @params}
    last_response.status.should eq 200
  end
end

describe "password and password_confirmation doesn't match" do
  it "should not register new user" do
    @params = {firstname: "tarun", lastname: "garg", email: "tarungarg402@gmail.com", 
                password: "1234567", password_confirmation: "12345678"}
    post "/create_signup", {user: @params}
    last_response.status.should eq 400
    JSON.parse(last_response.body).should eq({"errors"=>["Password confirmation doesn't match Password"]})
  end
end

describe "email should be uniq" do
  it "should not register new user" do
    @user = FactoryGirl.create(:user)
    @params = {firstname: "tarun", lastname: "garg", email: @user.email, 
                password: "1234567", password_confirmation: "1234567"}
    post "/create_signup", {user: @params}
    last_response.status.should eq 400
    JSON.parse(last_response.body).should eq({"errors"=>["Email has already been taken"]})
  end
end

describe "presence of all field is important" do
  it "should not register new user" do
    @user = FactoryGirl.create(:user)
    @params = {firstname: "", lastname: "", email: "", 
                password: "1234567", password_confirmation: "1234567"}
    post "/create_signup", {user: @params}
    last_response.status.should eq 400
    JSON.parse(last_response.body).should eq({"errors"=>["Email can't be blank", "Firstname can't be blank", "Lastname can't be blank"]})
  end
end

describe "sign in page" do
  it "should get sign in page" do
    get "/sign_in"
    last_response.status.should eq 200
    last_response.body.should match("signIn_button")
  end
end

describe "sign in into applicaiton" do
  it "should sign in the existing user" do
    @user = FactoryGirl.create(:user)
    @params = {email: @user.email, 
                password: @user.password}
    post "/create_sign_in", {user: @params}
    last_response.status.should eq 200
  end
end

describe "email is wrong" do
  it "should not sign in" do
    @user = FactoryGirl.create(:user)
    @params = {email: "tarungarg402@gmail.com", 
                password: @user.password}
    post "/create_sign_in", {user: @params}
    last_response.status.should eq 400
    JSON.parse(last_response.body).should eq({"error"=>"Invalid Username and password"})
  end
end

describe "password is wrong" do
  it "should not sign in" do
    @user = FactoryGirl.create(:user)
    @params = {email: @user.email, 
                password: @user.password+"this"}
    post "/create_sign_in", {user: @params}
    last_response.status.should eq 400
    JSON.parse(last_response.body).should eq({"error"=>"Invalid Username and password"})
  end
end

describe "logout user" do
  it "should logout user" do
    @user = FactoryGirl.create(:user)
    @params = {email: @user.email,
                password: @user.password}
    post "/create_sign_in", {user: @params}
    delete "/destroy_user"
    last_response.status.should eq 302
    last_response.should be_redirect
  end
end

describe "product list" do
  before(:each) do
    @user = FactoryGirl.create(:user_with_products)
    @params = {email: @user.email,
                password: @user.password}
    post "/create_sign_in", {user: @params}
  end
  
  it "should show list of products" do
    get "/products"
    last_response.status.should eq 200
    expect(last_response.body).to match('edit_product')
  end
  
  it "should show add new product page" do
    get "/new_product"
    last_response.status.should eq 200
    expect(last_response.body).to match('add_product')
  end

  it "should show add new product page" do
    get "/new_product"
    last_response.status.should eq 200
    expect(last_response.body).to match('add_product')
  end

  it "should add new product" do
    param = {name: "Soap", price: "45.54", status: "on", description: "soap for bath"}
    before_count = Product.count
    post "/add_product", {product: param}
    after_count = Product.count
    last_response.status.should eq 200
    expect(before_count).to be < after_count
  end

  it "should show errors" do
    param = {name: "", price: "", status: "", description: ""}
    before_count = Product.count
    post "/add_product", {product: param}
    after_count = Product.count
    expect(before_count).to be == after_count
    JSON.parse(last_response.body).should eq({"errors"=>["Name can't be blank", "Price can't be blank", "Price is not a number", "Description can't be blank"]})
  end 

  it "should update product" do
    pro = Product.first
    param = {name: "Soap", price: pro.price, status: pro.status, description: pro.description}
    before_name = pro.name
    put "/update_product/#{pro.id}", {product: param}
    after_name = Product.find(pro.id).name
    param[:name].should eq(after_name)
  end

  
end
