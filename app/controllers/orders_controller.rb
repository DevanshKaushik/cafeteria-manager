class OrdersController < ApplicationController
  before_action(only: :show) { check_privilige("clerk", "owner") }

  def index
    @target = params[:target]
    @user_id = params[:user_id]

    if @user_id
      check_privilige("clerk", "owner")
    end
  end

  def show
    @id = params[:id]
  end

  def update
    id = params[:id]
    order = Order.find(id)
    redirect_path = "/"

    if params[:place]
      # Checking if the menu item is present
      items_present = true

      order.order_items.each do |item|
        unless item.menu_item && item.menu_item.menu.active
          items_present = false
          break
        end
      end

      if items_present
        order.date = DateTime.now
        flash[:notice] = "Order placed successfully"
        redirect_path = orders_path
      else
        # Destroying all the order_items and redirecting to the menus path
        order.order_items.each { |item| item.destroy }
        flash[:alert] = "Some items in your cart are not available"
        redirect_path = menus_path
      end
    elsif params[:deliver]
      order.delivered_at = DateTime.now
      flash[:notice] = "Order##{id} marked as delivered"
    end

    if order.save
      redirect_to redirect_path
    else
      flash[:notice] = nil
      flash[:alert] = nil
      flash[:error] = order.errors.full_messages.join("\n")
      redirect_to "/"
    end
  end
end
