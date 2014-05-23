module ApplicationHelper

  def note_colour(note_name)
    if note_name.include?('#')
      'black'
    else
      'white'
    end 
  end

  def check_local_request
    unless local_request?
      flash[:warning] = "This action can only be called from the conductors computer."
      redirect_to '/'
    end
  end

  def conductor?
    conductor_ips = YAML.load_file("#{Rails.root}/config/conductor_ips.yml")
    conductor_ips.include?(request.remote_ip)
  end

  
 
end
