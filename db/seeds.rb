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


unless EventProfile.find_by_name('Chromatic Bass')
  EventProfile.create({
    name: 'Chromatic Bass',
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

unless EventProfile.find_by_name('Pentatonic Bass')
  EventProfile.create({
    name: 'Pentatonic Bass',
    no_of_notes: 1, 
    min_note: 36,
    max_note: 60,
    midi_notes: [36,39,41,43,46,48,51,53,55,58,60],
    length_steps: [1,2,3,4,8],
    default_length_steps: 2, 
    active: false,
    ip_address: '127.0.0.1',
    port: 9901
  })
end

unless EventProfile.find_by_name('Chromatic Blip')
  EventProfile.create({
    name: 'Chromatic Blip',
    no_of_notes: 1,
    min_note: 60,
    max_note: 95,
    length_steps: [1,2,4],
    default_length_steps: 2,
    active: true,
    ip_address: '127.0.0.1',
    port: 9910
  })
end

unless EventProfile.find_by_name('Pentatonic Blip')
  EventProfile.create({
    name: 'Pentatonic Blip',
    no_of_notes: 1,
    min_note: 60,
    max_note: 94,
    midi_notes: [60,63,65,67,70,
                 72,75,77,79,82,
                 84,87,89,91,94],
    length_steps: [1,2,4],
    default_length_steps: 2,
    active: false, 
    ip_address: '127.0.0.1',
    port: 9911
  })
end


unless EventProfile.find_by_name('Chromatic Chord')
  EventProfile.create({
    name: 'Chromatic Chord',
    no_of_notes: 3,
    min_note: 60,
    max_note: 79,
    length_steps: [4,8],
    default_length_steps: 8,
    active: true,
    ip_address: '127.0.0.1',
    port: 9920
  })
end

unless EventProfile.find_by_name('Pentatonic Chord')
  EventProfile.create({
    name: 'Pentatnoic Chord',
    no_of_notes: 3,
    min_note: 60,
    max_note: 79,
    midi_notes: [60,63,65,67,70,72,75,77,79],    
    length_steps: [4,8],
    default_length_steps: 8,
    active: false,
    ip_address: '127.0.0.1',
    port: 9921
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






