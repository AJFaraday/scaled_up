require 'test_helper'

class SampleGroupTest < ActiveSupport::TestCase

  test 'create_from_hash' do
    test_hash = {
      Cat: {
        Miow: 'miow',
        Purrrr: 'purr',
        Hisss: 'hiss'
      },
      Dog: {
        Woof: 'bark',
        Growl: 'growl'
      }
    }
    SampleGroup.create_from_hash(test_hash)
    group = SampleGroup.find_by_name('Dog')
    assert group
    assert group.samples.find_by_display_name('Woof')
  end

end
