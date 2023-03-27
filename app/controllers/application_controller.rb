class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  helper_method :current_user,
                :logged_in?

  private

  def authenticate_user!
    unless logged_in?
      redirect_url_remember
    end
    unless current_user
      redirect_to login_path, alert: 'Есть доступ в TestGuru? Проверьте пожалуйста ваш email и пароль.'
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def redirect_url_remember
    cookies[:redirect_url] = request.url
  end
end
