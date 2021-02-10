class HomeController < ApplicationController
  skip_before_action :ensure_user_login

  def index
    if !current_user
      render "index"
      return
    end

    if current_user.role == "customer"
      redirect_to menus_path
    else
      redirect_to dashboard_path
    end
  end
end
