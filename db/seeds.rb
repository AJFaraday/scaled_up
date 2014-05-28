# Generate notes (midi notes 21 - 108)
Note.create_initial

# SystemSettings created from config/system_settings.yml

SystemSetting.create_from_config

# Create Sample Groups

sample_groups = {
  Drums: {
    Kick: 'kick', 
    Snare: 'snare',
    "HiHat" => 'hat',
    Tom1: 'tom1',
    Tom2: 'tom2',
    Top3: 'tom3',
    Cymbal: 'cymbal'
  },
  Kalimba: {
    # For some reason the JSON style hash syntax doesn't like numbers as keys
    "1" => "kalimba1",
    "2" => "kalimba2",
    "3" => "kalimba3",
    "4" => "kalimba4",
    "5" => "kalimba5",
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

unless Length.count > 0
  Length.create!(name: 'Quaver', steps: 1, image: 'quaver.png')
  Length.create!(name: 'Crotchet', steps: 2, image: 'crotchet.png')
  Length.create!(name: 'Dotted Crotchet', steps: 3, image: 'dotted-crotchet.png')
  Length.create!(name: 'minim', steps: 4, image: 'minim.png')
  Length.create!(name: 'semibreve', steps: 8, image: 'semibreve.png')
end


unless EventProfile.find_by_name('Bass')
  EventProfile.create({
    name: 'Bass',
    no_of_notes: 1, 
    min_note: 36,
    max_note: 60,
    length_steps: [1,2,3,4,8],
    default_length_steps: 2,
    active: true,
    ip_address: '127.0.0.1',
    port: 9900
  })
end


unless EventProfile.find_by_name('Blip')
  EventProfile.create({
    name: 'Blip',
    no_of_notes: 1,
    min_note: 60,
    max_note: 95,
    length_steps: [1,2,4],
    default_length_steps: 2,
    active: false,
    ip_address: '127.0.0.1',
    port: 9910
  })
end

unless EventProfile.find_by_name('Chord')
  EventProfile.create({
    name: 'Chord',
    no_of_notes: 3,
    min_note: 60,
    max_note: 79,
    length_steps: [4,8],
    default_length_steps: 8,
    active: false,
    ip_address: '127.0.0.1',
    port: 9920
  })
end


unless EventProfile.find_by_name('Drum Kit')
  EventProfile.create({
    name: 'Drum Kit',
    sample_group_id: SampleGroup.find_by_name('Drums').id,
    length_steps: [1,2,4],
    default_length_steps: 2,
    active: false,
    ip_address: '127.0.0.1',
    port: 9930
  })
end

unless EventProfile.find_by_name('Kalimba')
  EventProfile.create({
    name: 'Kalimba',
    sample_group_id: SampleGroup.find_by_name('Kalimba').id,
    length_steps: [1,2,4,8],
    default_length_steps: 1,
    active: false,
    ip_address: '127.0.0.1',
    port: 9930
  })
end


unless Scale.find_by_name('Chromatic')
  Scale.create!(
    name: 'Chromatic',
    current: true,
    note_indexes: [0,1,2,3,4,5,6,7,8,9,10,11],
    offset: 0
  )
end

unless Scale.find_by_name('Major')
  Scale.create!(
    name: 'Major',
    current: false,
    note_indexes: [0,2,4,5,7,9,11],
    offset: 0
  )
end

unless Scale.find_by_name('Minor')
  Scale.create!(
    name: 'Minor',
    current: false,
    note_indexes: [0,2,3,5,7,8,10],
    offset: 0
  )
end

unless Scale.find_by_name('Major Pentatonic')
  Scale.create!(
    name: 'Major Pentatonic',
    current: false,
    note_indexes: [0,2,4,7,9],
    offset: 0
  )
end

unless Scale.find_by_name('Minor Pentatonic')
  Scale.create!(
    name: 'Minor Pentatonic',
    current: false,
    note_indexes: [0,3,5,7,10],
    offset: 0
  )
end

unless Scale.find_by_name('Whole Tone')
  Scale.create!(
    name: 'Whole Tone',
    current: false,
    note_indexes: [0,2,4,6,8,10],
    offset: 0
  )
end

unless Scale.find_by_name('Diminished')
  Scale.create!(
    name: 'Diminished',
    current: false,
    note_indexes: [0,3,6,9],
    offset: 0
  )
end

