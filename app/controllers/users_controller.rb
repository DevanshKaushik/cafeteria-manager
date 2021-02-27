class UsersController < ApplicationController
  skip_before_action :ensure_user_login

  before_action(only: [:index, :show, :destroy, :edit]) { check_privilige("owner") }

  def index
  end

  def show
    @id = params[:id]
  end

  def edit
    @id = params[:id]
    render "edit"
  end

  def destroy
    id = params[:id]
    user = User.find_by(id: id)

    if user
      user.orders.each { |order| order.order_items.each { |item| item.destroy } }
      user.orders.each { |order| order.destroy }
      user.destroy
    else
      flash[:error] = "No user found"
    end

    redirect_to "/"
  end

  def update
    role = params[:role].nil? ? "customer" : params[:role]

    user = User.find(params[:id])
    user.first_name = params[:first_name]
    user.last_name = params[:last_name]
    user.email = params[:email]
    user.role = role

    if !user.save
      flash[:error] = user.errors.full_messages.join("\n")
    end

    redirect_to "/"
  end

  def new
  end

  def create
    role = params[:role].nil? ? "customer" : params[:role]

    new_user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      role: role,
    )

    if new_user.save
      session[:current_user_id] = new_user.id
      redirect_to "/"
    else
      flash[:error] = new_user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
