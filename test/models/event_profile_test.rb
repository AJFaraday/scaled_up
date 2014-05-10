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



end
