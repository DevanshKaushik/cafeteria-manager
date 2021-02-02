class OrdersController < ApplicationController
  def index
  end

  def update
    order = Order.find(params[:id])

    if params[:place]
      order.date = DateTime.now
      flash[:notice] = "Order placed successfully"
    elsif params[:deliver]
      order.delivered_at = DateTime.now
      flash[:notice] = "Order marked as delivered"
    end

    if order.save
      redirect_to orders_path
    else
      flash[:notice] = nil
      flash[:error] = order.errors.full_messages.join("\n")
      redirect_to orders_path
    end
  end
end
