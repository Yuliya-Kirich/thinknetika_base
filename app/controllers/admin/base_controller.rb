class Admin::BaseController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :admin_required!

  private

  def admin_required!
    redirect_to root_path, alert: 'Авторизуйтесь для просмотра данной страницы.' unless current_user.admin?
  end
end
