class Length < ActiveRecord::Base

  has_and_belongs_to_many :event_profiles
  has_many :events

end
