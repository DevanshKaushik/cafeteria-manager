class MenusController < ApplicationController
  before_action(only: [:new]) { check_privilige("owner") }

  def index
  end

  def new
  end
end
