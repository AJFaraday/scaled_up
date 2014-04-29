# Generate notes (midi notes 21 - 108)

octave_notes = %w{C C# D D# E F F# G G# A A# B}

# midi note A0
midi_note = 21
# Starts on an A
octave_index = 9
# starts octave 0
octave = 0

until midi_note > 108
  note = octave_notes[octave_index%12]
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

# Create Sample Groups

sample_groups = {
  Drums: {
    Kick: 'kick', 
    Snare: 'snare',
    "HiHat" => 'hat',
    Crash: 'crash',
    Ride: 'ride',
    Tom1: 'tom1',
    Tom2: 'tom2',
    Top3: 'tom3'
  },
  Noises: {
    Beep: 'beep',
    Boop: 'boop',
    Hiss: 'hiss',
    Clatter: 'clatter'
  }
}
SampleGroup.create_from_hash(sample_groups)

