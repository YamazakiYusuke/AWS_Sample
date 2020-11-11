class UsersController < ApplicationController
  before_action :are_you_owner?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save 
      session[:user_id] = @user.id
      redirect_to tasks_path, notice: "ログインしました"
    else
      render :new
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation )
  end

  def are_you_owner?
    if current_user == nil || current_user.id != params[:id].to_i
      redirect_to tasks_path, notice: 'このページにはアクセスできません'
    end
  end
end
