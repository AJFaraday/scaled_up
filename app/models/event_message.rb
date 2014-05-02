class EventMessage < ActiveRecord::Base

  belongs_to :event
  belongs_to :event_profile 

  def play(pd_connection) 
    puts self.display_message
    pd_connection.send("#{self.content};\n",0)
    self.update_attribute :played, true
  end

end
