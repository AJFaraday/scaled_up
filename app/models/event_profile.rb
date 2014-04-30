class EventProfile < ActiveRecord::Base

  belongs_to :sample_group
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
