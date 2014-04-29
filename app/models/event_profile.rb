class EventProfile < ActiveRecord::Base

  belongs_to :sample_group

  has_many :events

  has_and_belongs_to_many :notes

end
