class ApplicationController < ActionController::Base

  # in order to make methods available in views we need to assign those methods as helper_method
  helper_method :current_chef, :logged_in?

  def current_chef
    # that means if current_chef is assigned then simply return it if it is not hit db and get the result and return it
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]
  end

  def logged_in?
    # !! will return true or false
    !!current_chef
  end

  def require_user
    unless logged_in?
      flash[:danger] = "You must be logged in"
      redirect_to root_path
    end
  end

end
