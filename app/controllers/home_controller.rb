class HomeController < ApplicationController
  skip_before_action :ensure_user_login

  def index
    if current_user
      if @current_user.role == "customer"
        redirect_to menus_path
      elsif @current_user.role == "clerk"
        render plain: "Welcome Clerk"
      else
        redirect_to dashboard_path
      end
    else
      render "index"
    end
  end
end
