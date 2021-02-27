class MenusController < ApplicationController
  before_action(only: [:new, :edit, :update, :destroy]) { check_privilige("owner") }

  def index
  end

  def create
    new_menu = Menu.new(
      name: params[:name],
      active: false,
    )

    if new_menu.save
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

  def update
    id = params[:id]

    if params[:active]
      Menu.set_active(id)
    elsif params[:menu_name]
      menu = Menu.find(id)
      menu.name = params[:menu_name]

      unless menu.save
        flash[:error] = menu.errors.full_messages.join("\n")
      end
    end

    redirect_to edit_menu_path(id)
  end

  def destroy
    menu = Menu.find(params[:id])

    if menu.active
      flash[:error] = "Active menu cannot be deleted"
    else
      menu.destroy
      flash[:notice] = "#{menu.name} has been deleted"
    end

    redirect_to "/"
  end
end
