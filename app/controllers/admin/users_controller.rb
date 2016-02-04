class Admin::UsersController < ApplicationController
  before_filter :restrict_to_admin

  def index 
    @users = User.all 
  end

  def new 
    @user = User.new
  end


  protected

 def user_params
        params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
      end
end
