class Note < ActiveRecord::Base

  has_and_belongs_to_many :events
  has_and_belongs_to_many :event_profiles

  NOTE_NAMES = %w{C C# D D# E F F# G G# A A# B}

  def Note.create_initial
    # midi note A0
    midi_note = 21
    octave_index = 9
    octave = 0

    until midi_note > 108
      note = NOTE_NAMES[octave_index%12]
      octave += 1 if note == 'C'
      puts "note: #{note}#{octave}"

      unless Note.find_by_name("#{note}#{octave}")
        Note.create(
          name: "#{note}#{octave}",
          midi_note: midi_note
        )
      end

      octave_index += 1
      midi_note += 1
    end
  end 
 
end
