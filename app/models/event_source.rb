class EventSource < ActiveRecord::Base  

  self.primary_key = :source

  has_many :note_stats, 
           class_name: 'EventSourceNoteStat',
           foreign_key: :source, 
           primary_key: :source

  has_many :sample_stats,              
           class_name: 'EventSourceSampleStat',
           foreign_key: :source, 
           primary_key: :source


end

