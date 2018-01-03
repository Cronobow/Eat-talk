class Dark::BaseController < ApplicationController
  before_action :authenticate_admin

  private

  def authenticate_admin
    unless current_user.is_admin?
      flash[:alert] = "Not allow!"
      redirect_to root_path
    end
  end

end
