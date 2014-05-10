require 'test_helper'

class SystemSettingTest < ActiveSupport::TestCase

  def test_get
    x = SystemSetting.get('quaver_time')
    puts x.inspect
    assert x.is_a?(Integer)
    assert_equal 220, x
  end

end
