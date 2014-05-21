class Scale < ActiveRecord::Base

  validates_presence_of :name

  cattr_accessor :current_scale

  def Scale.current
    return @current_scale if @current_scale
    @current_scale = Scale.where(:current => true).first
  end

  after_save :set_current

  def set_current
    if self.current
      Scale.where("current = ? and id != ?", true, self.id).each do |scale|
        scale.update_attribute :current, false
      end
    end
  end

  NOTES=%w{
    c c_sharp 
    d d_sharp 
    e
    f f_sharp 
    g g_sharp 
    a a_sharp 
    b
  }


  # Accepts an array of indexes and sets the columns
  #
  # e.g. [0,4,7,8] will 'true' c, e, g and g_sharp
  def note_indexes=(indexes)
    Scale::NOTES.each{|note|self.send("#{note}=",false)}
    indexes.each do |index|
      self.send("#{Scale::NOTES[index]}=", true)
    end
  end

  def note_bits
    Scale::NOTES.collect{|note_name| self.send(note_name)}
  end
 
  def note_indexes
    Array(0..11).select{|i| note_bits[i]}
  end

  # running out of words for notes, used notez
  def midi_notes
    midi_notez = self.note_indexes.collect do |index|
      10.times.collect do |octave|
        (octave * 12) + index
      end
    end
    midi_notez = midi_notez.flatten.sort
  end

  def notes
    Note.where("midi_note in (?)", midi_notes)
  end


 

end
