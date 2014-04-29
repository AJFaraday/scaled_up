class SampleGroup < ActiveRecord::Base

  has_many :samples

  has_many :event_profiles

end
