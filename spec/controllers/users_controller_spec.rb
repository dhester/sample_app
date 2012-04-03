require 'spec_helper'

describe UsersController do
 render_views

describe "GET 'show'" do
before(:each) do
@user = Factory(:user)
end

    it "should be successful" do
      get :show, :id => @user
      response.should be_success
    end

it "should find the right user" do
get :show, :id => @user
assigns(:user).should == @user

  end
it "should have the right title" do
get :show, :id => @user
response.should have_selector("title", :content => @user.name)
end
it "should have the user's name" do
get :show, :id => @user
response.should have_selector("h1", :content => @user.name)
end/* User show page */
table.profile {
width: 100%;
margin-bottom: 0;
}
td.main {
width: 70%;
padding: 1em;
}
td.sidebar {
width: 30%;
padding: 1em;
vertical-align: top;
background: #ffc;
}
.profile img.gravatar {
border: 1px solid #999;
margin-bottom: -15px;
}
it "should have a profile image" do
get :show, :id => @user
response.should have_selector("h1>img", :class => "gravatar")
end

end
  describe "GET 'new'" do

    it "should be successful" do
      get :new
      response.should be_success
    end
it "should have the right title" do
 get :new
 response.should have_selector("title", :content => "Sign up")
	end
  end
end
end
