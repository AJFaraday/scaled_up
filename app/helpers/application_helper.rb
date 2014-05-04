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

  def local_request?
    puts request.remote_ip
    request.remote_ip == '127.0.0.1'
  end

  
 
end
