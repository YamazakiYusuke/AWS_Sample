class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save 
      redirect_to tasks_path, notice: "アカウントを作成しました!"
    else
      render :new
    end
  end

  def show
    @user = User.find(current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(params[:id])

    if@user.update(user_params)
      redirect_to user_path(current_user.id), notice: "アカウント情報を更新しました!" 
    else
      redirect_to edit_user_path(current_user.id), notice: "アカウント情報の更新に失敗" 
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation )
  end
end
