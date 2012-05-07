class UsersController < ApplicationController
  before_filter :authenticate, :except => [:show, :new, :create]
before_filter :correct_user, :only => [:edit, :update]
before_filter :admin_user, :only => :destroy
before_filter :signed_in_user, :only => [:new, :create]

def index
@users = User.paginate(:page => params[:page])
@title = "All users"
end

def show
@user = User.find(params[:id])
@microposts = @user.microposts.paginate(:page => params[:page])
@title = @user.name
end

def following
show_follow(:following)
end

def followers
show_follow(:followers)
end

def show_follow(action)
@title = action.to_s.capitalize
@user = User.find(params[:id])
@users = @user.send(action).paginate(:page => params[:page])
render 'show_follow'
end

def new
@user = User.new  
@title = "Sign up" 
end

def signed_in_user
if signed_in?
flash[:info]="You're already logged in."
redirect_to(root_path)
end
end

def create
 @user = User.new(params[:user]) 
 if @user.save
  sign_in @user
 redirect_to @user, :flash => { :success => "Welcome to the Sample App!"}
 else
 @title = "Sign up"
 @user.password =""
 @user.password_confirmation=""
 render 'new'
  end
end

def edit
@title = "Edit user"
  end

def update
@user = User.find(params[:id])
if @user.update_attributes(params[:user])
 flash[:success] = "Profile updated."
 redirect_to @user
else
@title = "Edit user"
render 'edit'
  end
 end

def destroy
@user.destroy
flash[:success] = "User destroyed."
redirect_to users_path
end

private

 def authenticate
  deny_access unless signed_in?
 end

def correct_user
 @user = User.find(params[:id])
 redirect_to(root_path) unless current_user?(@user)

end

def admin_user
@user = User.find(params[:id])
redirect_to(root_path) if !current_user.admin? || current_user?(@user) 

end
end 

