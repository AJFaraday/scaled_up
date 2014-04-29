# Generate notes (midi notes 21 - 108)
Note.create_initial

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

unless EventProfile.find_by_name('Chromatic Bass')
  EventProfile.create({
    name: 'Chromatic Bass',
    no_of_notes: 1, 
    min_note: 36,
    max_note: 60
  })
end

unless EventProfile.find_by_name('Pentatonic Bass')
  EventProfile.create({
    name: 'Pentatonic Bass',
    no_of_notes: 1, 
    min_note: 36,
    max_note: 60,
    midi_notes: [36,39,41,43,46,48,51,53,55,57,60]
  })
end
