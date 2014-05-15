class EventProfile < ActiveRecord::Base

  belongs_to :sample_group
  has_many :samples, through: :sample_group

  delegate :name, to: :sample_group, allow_nil: true, prefix: 'sample_group'

  has_many :event_profile_sample_stats
  has_many :event_profile_source_stats

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

  has_many :event_messages  

  attr_accessor :pd_connection
  attr_accessor :current_event_message
  attr_accessor :steps_until_play
  attr_accessor :current_played

  def unplayed_messages
    if last_played_message_id
      event_messages.where(['played = ? and id > ?', false, last_played_message_id]).order("id asc")
    else
      event_messages.where(:played => false).order("id asc")
    end
  end

  # TODO This doesn't error here because it sends no messages to the connection
  # TODO Send one, and make sure the player ignores the profile
  # TODO and reports the failure to the console.
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
      self.current_event_message = unplayed_messages.first
      if self.current_event_message
        self.steps_until_play = current_event_message.steps - 1
        self.current_played = false
      end 
    end
  end 

  def play_current_event_message
    if self.current_event_message and self.current_played == false
      self.current_event_message.play(self.pd_connection)
      self.current_played = true
      self.last_played_message_id = self.current_event_message.id
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

  def notes_summary
     if min_note and max_note
       min = Note.find_by_midi_note(min_note).name
       max = Note.find_by_midi_note(max_note).name
       "#{no_of_notes} from #{min} to #{max}"
     else 
       "N/A"
     end
  end

  def samples_summary
    if sample_group
      sample_group_name
    else
      "N/A"
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

  def toggle_active
    if active
      update_attribute :active, false
    else
      update_attribute :active, true
    end
  end

  def EventProfile.select_options
    EventProfile.active.collect{|x|[x.name,x.id]}
  end

  def EventProfile.active
    where(:active => true)
  end 

  # TODO - actually catch non-connecting profiles here
  def EventProfile.all_with_pd_connections
    event_profiles = EventProfile.all.select do |event_profile|
      event_profile.pd_connection ? true : false
    end
    if event_profiles.any?
      puts "#{event_profiles.count} event profiles connected."
      puts event_profiles.collect{|x|x.name}.inspect
      unconnected = EventProfile.all - event_profiles
      puts "#{unconnected.count} event profiles could not connect."
      puts unconnected.collect{|x|x.name}.inspect
    else
      raise "No event profiles can make a connection!"
    end
    return event_profiles
  end

  def sql_for_note(note)
    <<-SQL
      select count(*) from events_notes en
      inner join notes n on n.id = en.note_id
      inner join events e on e.id = en.event_id
      inner join event_profiles ep on ep.id = e.event_profile_id
      where n.name like '%#{note}%' and n.name not like '%#{note}#%'
      and ep.id = #{self.id};
    SQL
  end

  def note_name_stats
    counts = {}
    notes = %w(A A# B C C# D D# E F F# G G#)
    notes.each do |note|
      query = sql_for_note(note)
      counts[note] = EventProfile.connection.select_all(query).rows[0][0]
    end
    counts
  end

  def note_names_bar_data
    name_stats = note_name_stats
    notes =  %w(A A# B C C# D D# E F F# G G#)
    data = {
      labels: notes,
      datasets: [
        {
          fillColor: '#FFFFFF',
          strokeColor: '#000000',
          data: notes.collect do |note|
            name_stats[note]
          end
        }
      ]
    }
    data.to_json
  end


  def sample_name_stats
    counts = {}
    self.samples.order('name asc').each do |sample|
      stat = event_profile_sample_stats.find_by_sample_id(sample.id)
      counts[sample.name] = (stat ? event_profile_sample_stats.find_by_sample_id(sample.id).cnt : 0)
    end
    counts
  end   

  def sample_names_bar_data
    name_stats = sample_name_stats
    samples = name_stats.keys
    data = {
      labels: samples,
      datasets: [
        {
          fillColor: '#FFFFFF',
          strokeColor: '#000000',
          data: name_stats.values
        }
      ]
    }
    data.to_json
  end

  PIE_COLOURS = %w{
    #eeeeee
    #cccccc
    #aaaaaa
    #888888
    #666666
    #444444
    #222222
    #000000
  }

  def source_stats_pie_data
    i = -1
    source_stats = event_profile_source_stats.collect{|x|x.cnt}
    result = source_stats.collect do |stat|
      i += 1
      {
        color: PIE_COLOURS[i % PIE_COLOURS.length],
        value: stat
      }
    end
    result.to_json    
  end

end
