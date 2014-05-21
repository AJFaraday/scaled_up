class EventProfileTest < ActiveSupport::TestCase

  test 'get_current_event_message' do
    event_profile = EventProfile.find(1)
    event_profile.get_current_event_message
    assert_equal 4, event_profile.current_event_message.id
    assert_equal 1, event_profile.steps_until_play
    # this would normally be done by play_current_event_,message
    event_profile.last_played_message_id = 4
    event_profile.get_current_event_message
    assert_equal 4, event_profile.current_event_message.id
    assert_equal 0, event_profile.steps_until_play
    event_profile.get_current_event_message
    assert_equal 5, event_profile.current_event_message.id
    assert_equal 1, event_profile.steps_until_play
  end

  test 'play_current_event_message' do
    event_profile = EventProfile.find(1)
    event_profile.get_current_event_message
    assert event_profile.pd_connection
    event_profile.play_current_event_message

    assert_equal 4, event_profile.current_event_message.id
    assert_equal 4, event_profile.last_played_message_id


    event_profile.get_current_event_message
    event_profile.get_current_event_message
    assert event_profile.pd_connection
    event_profile.play_current_event_message

    assert_equal 5, event_profile.current_event_message.id
    assert_equal 5, event_profile.last_played_message_id
  end


  test 'notes_in_range' do
    event_profile = EventProfile.find(1)
    x = event_profile.notes_in_range
    assert x.is_a?(Note::ActiveRecord_Relation)
    assert x[0].is_a?(Note)
    assert_equal 13, x.length
  end

  test 'notes_summary' do 
    event_profile = EventProfile.find(1)
    x = event_profile.notes_summary
    assert x.is_a?(String)
    assert x.include?('F#1')    
    assert x.include?('F#2')
    assert x.include?(event_profile.no_of_notes.to_s)
   
    event_profile = EventProfile.find(3)
    x = event_profile.notes_summary 
    assert x.is_a?(String)
    assert_equal 'N/A', x
  end

  test 'samples_summary' do
    event_profile = EventProfile.find(3)
    x = event_profile.samples_summary
    assert x.is_a?(String)
    assert_equal 'Drums', x

    event_profile = EventProfile.find(1)
    x = event_profile.samples_summary 
    assert x.is_a?(String)
    assert_equal 'N/A', x
  end
 
  test 'toggle_active' do
    event_profile = EventProfile.find(1)
    assert event_profile.active
    event_profile.toggle_active
    assert !event_profile.active
    event_profile.toggle_active
    assert event_profile.active
  end


end
