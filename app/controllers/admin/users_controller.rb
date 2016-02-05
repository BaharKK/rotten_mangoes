class Admin::UsersController < ApplicationController
  before_filter :restrict_to_admin

  def index 
    @users = User.all.page(params[:page]).per(10)
  end

  def new 
    @user = User.new
  end

  def edit 
    @user = User.find(params[:id])
  end

  def update 
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path(@user)
    else 
      render :edit 
    end
  end

  def create 
      @user = User.new(user_params)

      if @user.save 
        if @user.admin == true 
          redirect_to movies_path, notice: "Admin #{@user.firstname} created Successfully!"
        else
          redirect_to movies_path, notice: "User #{@user.firstname} created successfuly!"
        end
      else
        render :new 
      end
    end


  def show
    @user = User.find(params[:id]) 
  end

  def destroy 
    @user = User.find(params[:id])
    @user.destroy
    UserMailer.delete_email(@user).deliver
    redirect_to admin_users_path, notice: "User Deleted"
  end


  protected

 def user_params
        params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
      end
end
