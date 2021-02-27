class MenuItemsController < ApplicationController
  before_action { check_privilige("owner") }

  def destroy
    menu_item = MenuItem.find(params[:id])
    menu_item.destroy
    flash[:notice] = "#{menu_item.name} removed from the menu"
    redirect_to edit_menu_path(params[:menu_id])
  end

  def create
    new_menu_item = MenuItem.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      category: params[:category],
      menu_id: params[:menu_id],
    )
    unless new_menu_item.save
      flash[:error] = new_menu_item.errors.full_messages.join("\n")
    end

    redirect_to edit_menu_path(params[:menu_id])
  end

  def update
    menu_item = MenuItem.find(params[:id])
    menu_item.name = params[:name]
    menu_item.description = params[:desc]
    menu_item.price = params[:price]
    menu_item.category = params[:category]

    if menu_item.save
      flash[:notice] = "Menu item: #{menu_item.name}, updated successfully"
    else
      flash[:error] = menu_item.errors.full_messages.join("\n")
    end

    redirect_to edit_menu_path(menu_item.menu.id)
  end
end
