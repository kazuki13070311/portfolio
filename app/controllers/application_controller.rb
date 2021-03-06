class ApplicationController < ActionController::Base
  #protect_from_forgery with: :exception

  # ここから追加します
  before_action :configure_permitted_parameters, if: :devise_controller?
  #bifore_action :authenticate_user!
  #ログイン後のリダイレクト先
  def after_sing_in_path_for(resource)
    friends_path
    #"/user/#{current_user.id}"
  end

  protected

  #入力フォームからアカウント名情報をDBに保存するために追加
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name]) # 新規登録時(sign_up時)にnameというキーのパラメーターを追加で許可する
  end
end
