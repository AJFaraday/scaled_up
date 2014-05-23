class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def check_conductor
    unless conductor?
      flash[:warning] = "This action can only be called from the conductors computers."
      redirect_to '/'
    end
  end

  def conductor?
    conductor_ips = YAML.load_file("#{Rails.root}/config/conductor_ips.yml")
    conductor_ips.include?(request.remote_ip)
  end
end
