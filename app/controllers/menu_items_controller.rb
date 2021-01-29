class MenuItemsController < ApplicationController
  before_action { check_privilige("owner") }

  def create
    new_menu_item = MenuItem.new(
      name: params[:name],
      description: params[:description],
      price: params[:price],
      category: params[:category],
      menu_id: params[:menu_id],
    )
    if !new_menu_item.save
      flash[:error] = new_menu_item.errors.full_messages.join("\n")
    end

    redirect_to edit_menu_path(params[:menu_id])
  end
end
