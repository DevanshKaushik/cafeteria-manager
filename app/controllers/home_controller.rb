class HomeController < ApplicationController
  skip_before_action :ensure_user_login

  def index
    if current_user
      if @current_user.role == "customer"
        redirect_to menus_path
      else
        render plain: "Welcome owner"
      end
    else
      render "index"
    end
  end
end
