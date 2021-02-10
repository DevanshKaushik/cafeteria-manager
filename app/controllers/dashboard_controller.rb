class DashboardController < ApplicationController
  before_action { check_privilige("owner", "clerk") }

  def index
    @role = current_user.role
  end
end
