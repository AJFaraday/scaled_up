class EventMessage < ActiveRecord::Base

  belongs_to :event
  belongs_to :event_profile 

  def play(pd_connection) 
    pd_connection.send(self.content)
    self.update_attribute :played, true
  end

end
