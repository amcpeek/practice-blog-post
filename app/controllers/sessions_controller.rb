class SessionsController < ApplicationController
  def new
    # Login form
  end

  def create
    user = User.find_by(email: params[:email]&.downcase&.strip)

    if user
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, #{user.full_name}!"
      redirect_to root_path
    else
      flash.now[:alert] = "Email not found. Please check your email address."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to root_path
  end
end
