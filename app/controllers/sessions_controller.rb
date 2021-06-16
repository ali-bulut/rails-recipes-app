class SessionsController < ApplicationController

  def new

  end

  def create
    # we may use directly params[:session][:email]
    chef = Chef.find_by(email: login_params[:email].downcase)
    if chef && chef.authenticate(login_params[:password])
      # assigning chef_id to browser session
      session[:chef_id] = chef.id
      flash[:success] = "You have successfully logged in"
      # we may use chef_path(chef)
      redirect_to chef
    else
      flash.now[:danger] = "There was something wrong with your login information"
      # render is not calling http request. So if we don't use .now it will be shown up after going to another page.
      # because flash lives for only one http request.
      render 'new'
    end
  end

  def destroy
    session[:chef_id] = nil
    flash[:success] = "Logged out"
    redirect_to root_path
  end

  private

  def login_params
    params.require(:session).permit(:email, :password)
  end

end