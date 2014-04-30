class Event < ActiveRecord::Base


  has_and_belongs_to_many :notes
  
  belongs_to :sample

  belongs_to :event_profile

  delegate :octaves, :to => :event_profile

  after_initialize :init_event_profile

  def init_event_profile
    self.event_profile_id ||= EventProfile.first.id
  end 

  attr_accessor :midi_notes
  
  def midi_notes
    self.notes.collect{|x|x.midi_note}
  end

  def midi_notes=(value=[])
    self.notes = Note.where(:midi_note => value).all
  end


  def Event.length_options
    [
      ['Crotchet',1],
      ['Quaver', 2],
      ['Semibreve', 4]
    ]
  end

end
