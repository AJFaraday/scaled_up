class EventProfile < ActiveRecord::Base

  belongs_to :sample_group
  has_many :events
  has_and_belongs_to_many :notes
  before_save :initialise_notes
  validates_uniqueness_of :name

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

end
