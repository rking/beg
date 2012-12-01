require 'test_helper'
require 'beg'

class BegTest < MiniTest::Unit::TestCase
  def test_cli
    def Beg.loop; yield end # Just go through once, thanks. ☺
    sys = []
    Beg.stub :system, -> *args { sys << args } do
      Beg.cli []
    end
    watch_cmd, test_cmd = sys
    assert_equal 'inotifywait', watch_cmd[0]
    assert_equal %w(bundle exec rake test), test_cmd[0]
  end
end
