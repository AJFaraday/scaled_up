class Event < ActiveRecord::Base

  has_and_belongs_to_many :notes
  
  belongs_to :sample

  belongs_to :event_profile

end
