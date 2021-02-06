class OrderItemsController < ApplicationController
  def create
    current_order = Order.current_order(current_user.id)

    unless current_order
      flash[:error] = "There was some error processing your request. Please retry."
      redirect_to "/"
    end

    menu_item = MenuItem.find(params[:menu_item_id])

    new_order_item = OrderItem.new(
      order_id: current_order.id,
      menu_item_id: menu_item.id,
      menu_item_name: menu_item.name,
      menu_item_price: menu_item.price,
    )

    if new_order_item.save
      flash[:notice] = "#{menu_item.name} has been added to the cart"
    else
      flash[:error] = new_order_item.errors.full_messages.join("\n")
    end

    redirect_to "/"
  end

  def destroy
    order = OrderItem.find(params[:id])
    order.destroy
    flash[:notice] = "#{order.menu_item_name} has been removed from your cart"
    redirect_to orders_path
  end
end
