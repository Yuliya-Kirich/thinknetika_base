class SessionsController < ApplicationController
  def new
    redirect_to root_path if session[:user_id].present?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:redirect_url] || root_path
      cookies.delete :redirect_url
    else
      flash.now[:alert] = 'Уже имеете аккаунт в TestGuru? Проверьте пожалуйста ваш email и пароль.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end
end
