class Sample < ActiveRecord::Base

  belongs_to :sample_group
  has_many :events  

end
