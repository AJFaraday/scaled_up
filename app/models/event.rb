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

  belongs_to :length
  
  belongs_to :sample

  belongs_to :event_profile
  has_one :event_message

  delegate :octaves, :to => :event_profile

  after_initialize :init_event_profile

  after_create :create_event_message

  def init_event_profile
    self.event_profile_id ||= EventProfile.first.id
  end 

  def create_event_message
    if self.notes.any?
      @ms_length = (self.steps * SystemSetting.get('quaver_time'))
      @message = ""
      @display_message = "#{Note.model_name.human(count: notes.count)} "
      self.notes.each do |note|
        @message << "note #{note.midi_note} #{@ms_length};"
        @display_message << "#{note.name} "
      end
      @display_message << " #{self.length.name}"
    elsif self.sample
      @display_message = @message = "sample #{self.sample.name}"
    end
    EventMessage.create!(
      event_id: self.id,
      event_profile_id: self.event_profile_id,
      played: false,
      content: @message,
      steps: self.steps,
      display_message: "#{self.source.ljust(20)} - #{self.event_profile.name.ljust(20)} - #{@display_message}"
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

  def length_options
    self.event_profile.lengths.collect{|x|[x.name,x.id]}
  end

  def length_id=(value)
    super(value)
    self.steps = self.length.steps 
  end

  def event_profile_id=(value)
    super(value)
    self.length_id ||= self.event_profile.default_length_id
  end

  def has_note?(note_name)
    notes.names.include?(note_name)
  end

  def fix_inactive_profile
    if self.event_profile.active == false and EventProfile.active.any?
      self.event_profile_id = EventProfile.active.first.id
    end
  end

end
