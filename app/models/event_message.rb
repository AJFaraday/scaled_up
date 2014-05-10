class EventMessage < ActiveRecord::Base

  belongs_to :event
  belongs_to :event_profile 

  def play(pd_connection) 
    puts self.display_message
    self.content.split(';').each do |part|
      pd_connection.send("#{part};\n",0)
    end 
    self
  end

end
