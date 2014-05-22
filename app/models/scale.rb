class Scale < ActiveRecord::Base

  validates_presence_of :name

  cattr_accessor :current_scale

  def Scale.current
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


  # Accepts an array of indexes and sets bits column
  #
  # e.g. [0,4,7,8] will result in the bit-mask '100010011000'
  def note_indexes=(indexes)
    note_bits = ('0' * 12)
    indexes.each do |index|
      note_bits[index] = '1'
    end
    self.bits=note_bits.to_i(2)
  end

  def note_bits
    bits.to_s(2).chars.collect{|x|x=='1'}
  end
 
  def note_indexes
    array = Array(0..11).select{|i| note_bits[i]}
    array.collect{|x|(x + self.offset) % 12}.sort
  end

  # running out of words for notes, used notez
  def midi_notes
    midi_notez = self.note_indexes.collect do |index|
      10.times.collect do |octave|
        ((octave * 12) + index) 
      end
    end
    midi_notez = midi_notez.flatten.sort
  end

  def notes
    Note.where("midi_note in (?)", midi_notes)
  end


 

end
