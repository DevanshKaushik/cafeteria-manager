class OrdersController < ApplicationController
  def index
    @target = params[:target]
  end

  def update
    id = params[:id]
    order = Order.find(id)
    redirect_path = "/"

    if params[:place]
      path = orders_path
      order.date = DateTime.now
      flash[:notice] = "Order placed successfully"
      redirect_path = orders_path
    elsif params[:deliver]
      order.delivered_at = DateTime.now
      flash[:notice] = "Order##{id} marked as delivered"
    end

    if order.save
      redirect_to redirect_path
    else
      flash[:notice] = nil
      flash[:error] = order.errors.full_messages.join("\n")
      redirect_to "/"
    end
  end
end
