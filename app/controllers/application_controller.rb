class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def default_url_options
    { lang: I18n.locale == I18n.default_locale ? nil : I18n.locale }
  end

  def password_validation
    respond_to do |format|
      format.turbo_stream
    end
  end

  protected

  def after_sign_in_path_for(resource)
    if resource.admin?
      admin_tests_path
    else
      root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :full_name
  end

  def configure_permitted_parameters
    additional_params = [:first_name, :last_name, :email_confirmation,
                         { addresses_attributes: %i[address1 address2 city state zip country name] }]
    devise_parameter_sanitizer.permit(:sign_up, keys: additional_params)
    devise_parameter_sanitizer.permit(:account_update, keys: additional_params)
  end

  def redirect_url_remember
    cookies[:redirect_url] = request.url
  end

  private

  def set_locale
    I18n.locale = I18n.locale_available?(params[:lang]) != I18n.default_locale.to_s ? params[:lang] : I18n.default_locale
  end
end
