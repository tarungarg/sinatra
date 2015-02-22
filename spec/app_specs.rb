require File.expand_path '../spec_helper.rb', __FILE__

describe 'sign in page' do  
  it "should sign in" do
    get '/'
    last_response.should be_ok # it will true if the home page load successfully
  end
end