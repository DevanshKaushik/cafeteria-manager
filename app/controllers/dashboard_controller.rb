class DashboardController < ApplicationController
  before_action { check_privilige("owner") }

  def index
  end
end
