require 'test_helper'

class NoteTest < ActiveSupport::TestCase

  test 'create_initial' do
    Note.create_initial
    assert_equal 88, Note.count
    assert Note.find_by_name('A0')
    assert Note.find_by_name('C8')
  end

end
