require 'test_helper'

class EventTest < ActiveSupport::TestCase
 


  test 'init_event_profile' do
    e = Event.new
    assert e.event_profile
    EventProfile.active.each{|x|x.update_attribute :active, false}
    e = Event.new 
    assert !e.event_profile
  end

  test 'create_event_message' do
    init_count = EventMessage.count
    e = Event.find(1)
    e.create_event_message
    assert_equal init_count + 1, EventMessage.count
    em = EventMessage.last
    assert_equal e.id, em.event_id
    assert_equal e.event_profile_id, em.event_profile_id
    assert_equal false, em.played
    assert_equal e.steps, em.steps
  end

  test 'create_event_message for one note' do
    e = Event.create(
      event_profile_id: 1,
      source: 'testtesttest',
      length_id: 1,
      midi_notes: 30
    )
    em = e.event_message
    assert_equal 'note 30 220;', em.content   
  end

  test 'create_event_message for three notes' do
    e = Event.create(
      event_profile_id: 2,
      source: 'testtesttest',
      length_id: 1,
      midi_notes: [30,34,37]
    )
    em = e.event_message
    assert_equal 'note 30 220;note 34 220;note 37 220;', em.content
  end

  test 'create_event_message for drum' do
    e = Event.create(
      event_profile_id: 3,
      source: 'testtesttest',
      length_id: 1,
      sample_id: 1
    )
    em = e.event_message
    assert_equal 'sample kick;', em.content
  end

  test 'fix_inactive_profile' do
    e = Event.find(1)
    profile = e.event_profile
    profile.update_attribute :active, false
    e.fix_inactive_profile
    assert_not_equal profile, e.event_profile   
    EventProfile.active.each{|x|x.update_attribute :active, false}
    # this reload cleares the cached query of EventProfile
    e.reload
    e.fix_inactive_profile
    assert_nil e.event_profile_id
  end

end
