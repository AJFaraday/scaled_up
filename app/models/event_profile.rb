class EventProfile < ActiveRecord::Base

  belongs_to :sample_group
  has_many :samples, through: :sample_group

  has_and_belongs_to_many :lengths
  belongs_to :default_length, 
             class_name: 'Length',
             foreign_key: :default_length_id

  has_many :events
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
  before_save :initialise_notes
  validates_uniqueness_of :name

  has_many :event_messages do 
    def unplayed
      where(:played => false).order("id asc")
    end
  end

  attr_accessor :pd_connection
  attr_accessor :current_event_message
  attr_accessor :steps_until_play

  def pd_connection
    if @pd_connection
      @pd_connection
    else 
      begin
        self.pd_connection = UDPSocket.new
        self.pd_connection.connect(ip_address, port)
      rescue => er
        puts er.message
        puts "Can not connect to #{ip_address}:#{port}"
      end 
    end
  end

  def pd_connection=(value)
    @pd_connection=value
  end 

  def get_current_event_message
    self.steps_until_play ||= 0
    if self.steps_until_play > 0
      self.steps_until_play -= 1
    else
      self.current_event_message = event_messages.unplayed.first
      if self.current_event_message
        self.steps_until_play = current_event_message.steps - 1
      end 
    end
  end 

  def play_current_event_message
    if self.current_event_message and !self.current_event_message.played?
      self.current_event_message.play(self.pd_connection)
    end
  end 

  def has_note?(note_name)
    notes.names.include?(note_name)
  end

  def notes_in_range
    if min_note and max_note
      Note.where("midi_note >= #{min_note} and midi_note <= #{max_note}")
    else 
      []
    end
  end 

  def initialise_notes
    if self.notes_in_range.any? and self.note_ids.none?
      self.note_ids = self.notes_in_range.collect{|x|x.id}
    end
  end

  def midi_notes
    self.notes.collect{|x|x.midi_note}
  end

  def midi_notes=(value=[])
    self.notes = Note.where(:midi_note => value).all
  end

  def length_steps
    self.lengths.collect{|x|x.steps}
  end 

  def length_steps=(value=[])
    self.lengths = Length.where(:steps => value).all
  end

  def default_length_steps
    self.default_length.steps
  end

  def default_length_steps=(value)
    self.default_length_id= Length.find_by_steps(value).id
  end

  #
  # returns a sorted arraty of midi octaves for the related notes 
  #
  def octaves
    if notes.any?
      notes.collect{|n|n.name[-1]}.uniq.sort
    else 
      []
    end 
  end 

  def EventProfile.select_options
    all.collect{|x|[x.name,x.id]}
  end

end
