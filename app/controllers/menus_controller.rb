class MenusController < ApplicationController
  before_action(only: [:new, :edit]) { check_privilige("owner") }

  def index
  end

  def create
    new_menu = Menu.new(
      name: params[:name],
      active: false,
    )

    if new_menu.save
      Menu.set_active(new_menu.id)
      redirect_to edit_menu_path(new_menu.id)
    else
      flash[:error] = new_menu.errors.full_messages.join("\n")
      redirect_to "/"
    end
  end

  def edit
    @menu_id = params[:id]
    render "edit"
  end
end
