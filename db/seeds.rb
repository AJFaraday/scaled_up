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

sample_groups.each do |sample_group_name,sample_names|
  puts "SampleGroup: #{sample_group_name}"
  sample_group = SampleGroup.find_by_name(sample_group_name)
  sample_group ||= SampleGroup.create!(name: sample_group_name)

  sample_names.each do |display_name, name|
    puts " Sample: #{display_name}"
    unless sample_group.samples.find_by_display_name(display_name)
      sample_group.samples.create!(
        display_name: display_name,
        name: name
      )
    end
  end

end


