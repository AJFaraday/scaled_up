class EventSourceProfileStat < ActiveRecord::Base

  self.primary_key = :source
 
  belongs_to :event_source, 
             foreign_key: :source, 
             primary_key: :source

end
