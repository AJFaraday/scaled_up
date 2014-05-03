# Generate notes (midi notes 21 - 108)
Note.create_initial

# Create Sample Groups

sample_groups = {
  Drums: {
    Kick: 'kick', 
    Snare: 'snare',
    "HiHat" => 'hat',
    Tom1: 'tom1',
    Tom2: 'tom2',
    Top3: 'tom3',
    Ride: 'ride',
    Crash: 'crash'
  },
  Noises: {
    Beep: 'beep',
    Boop: 'boop',
    Hiss: 'hiss',
    Clatter: 'clatter',
    Bang: 'bang'
  }
}
SampleGroup.create_from_hash(sample_groups)

unless EventProfile.find_by_name('Chromatic Bass')
  EventProfile.create({
    name: 'Chromatic Bass',
    no_of_notes: 1, 
    min_note: 36,
    max_note: 60,
    ip_address: '127.0.0.1',
    port: 9901
  })
end

unless EventProfile.find_by_name('Pentatonic Bass')
  EventProfile.create({
    name: 'Pentatonic Bass',
    no_of_notes: 1, 
    min_note: 36,
    max_note: 60,
    midi_notes: [36,39,41,43,46,48,51,53,55,58,60],
    ip_address: '127.0.0.1',
    port: 9901
  })
end

unless EventProfile.find_by_name('Three Notes')
  EventProfile.create({
    name: 'Three Notes',
    no_of_notes: 3,
    min_note: 60,
    max_note: 78,
    ip_address: '127.0.0.1',
    port: 9902
  })
end

unless EventProfile.find_by_name('Drum Kit')
  EventProfile.create({
    name: 'Drum Kit',
    sample_group_id: SampleGroup.find_by_name('Drums').id,
    ip_address: '127.0.0.1',
    port: 9910
  })
end
