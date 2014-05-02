class Event < ActiveRecord::Base


  has_and_belongs_to_many :notes do

    def for_octave(octave)
      min = (octave * 12) + 12
      max = min + 11
      notes.where(midi_note: (min..max))
    end

    def names
      collect{|x|x.name}
    end

  end
  
  belongs_to :sample

  belongs_to :event_profile

  delegate :octaves, :to => :event_profile

  after_initialize :init_event_profile

  after_create :create_event_message

  def init_event_profile
    self.event_profile_id ||= EventProfile.first.id
  end 

  def create_event_message
    if self.notes.any?
      @message = ""
      self.notes.each do |note|
        @message << "note #{note.midi_note};"
      end
    elsif self.sample
      @message = "sample #{self.sample.name}"
    end
    EventMessage.create!(
      event_id: self.id,
      event_profile_id: self.event_profile_id,
      played: false,
      content: @message
    )
  end

  attr_accessor :midi_notes
  serialize :midi_notes, Array
  
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

  def has_note?(note_name)
    notes.names.include?(note_name)
  end

end
