class Sample < ActiveRecord::Base

  belongs_to :sample_group
  has_many :events 

  validates_uniqueness_of :name, :scope => :sample_group_id
  validates_uniqueness_of :display_name, :scope => :sample_group_id 

end
