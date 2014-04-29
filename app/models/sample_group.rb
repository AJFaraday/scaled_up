class SampleGroup < ActiveRecord::Base

  has_many :samples

  has_many :event_profiles

  validates_uniqueness_of :name

end
