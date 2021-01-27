class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def new
  end

  def create
    role = params[:role].nil? ? "customer" : params[:role]

    new_user = User.create!(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      password: params[:password],
      role: role,
    )
    response_text = "New user is created with the user_id: #{new_user.id}"
    render plain: response_text
  end
end
