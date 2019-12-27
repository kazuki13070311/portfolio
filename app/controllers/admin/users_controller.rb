# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :require_admin, only: [:index]
  skip_before_action :login_required, if: proc{action_name == "new" || action_name == "create"}
  
  def index
    @users = User.all
  end

  def show
    if current_user.admin
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
  end

  def new
    @user = User.new
    @admin = current_user.admin if current_user
  end

  def edit
    if current_user.admin
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
    @admin = current_user.admin if current_user
  end

  def create
    @user = User.new(user_params)
    #@user.active = false
    if @user.save
      session[:user_id] = @user.id unless current_user
      redirect_to admin_user_url(@user), notice: "ガーディアン「#{@user.name}を登録しました。」"
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_url(@user), notice: "ガーディアン「#{@user.name}」を更新しました。"
    else
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to admin_users_url, notice: "ガーディアン「#{@user.name}」を削除しました。"
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def require_admin
    if current_user
      redirect_to root_path unless current_user.admin?
    else
      redirect_to root_url
    end
  end
end