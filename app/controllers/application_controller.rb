class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) do |u| u.permit(:name, :email, :password, :password_confirmation, :nickname,:sex,:birth) end
      devise_parameter_sanitizer.permit(:account_update) do |u| u.permit(:name, :email, :password, :password_confirmation, :nickname,:sex,:birth) end
  end
  private
  def authorize_admin
    unless current_user&&current_user.is_admin
      redirect_to root_path, notice: "관리자 외 접근불가합니다."
    end
    #redirects to previous page
  end

end
