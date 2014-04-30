class Event < ActiveRecord::Base

  has_and_belongs_to_many :notes
  
  belongs_to :sample

  belongs_to :event_profile

  delegate :octaves, :to => :event_profile

  def midi_notes
    self.notes.collect{|x|x.midi_note}
  end

  def midi_notes=(value=[])
    self.notes = Note.where(:midi_note => value).all
  end


end
