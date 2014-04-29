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

