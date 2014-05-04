class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_local_request
    unless local_request?
      flash[:warning] = "This action can only be called from the conductors computer."
      redirect_to '/'
    end
  end

  def local_request?
    puts request.remote_ip
    request.remote_ip == '127.0.0.1'
  end
end
