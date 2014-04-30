module ApplicationHelper

  def note_colour(note_name)
    if note_name.include?('#')
      'black'
    else
      'white'
    end 
  end

  
 
end
