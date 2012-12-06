require 'test_helper'
require 'beg'

class BegTest < MiniTest::Unit::TestCase
  def with_fake_system_interaction returns
    beg = Beg.new
    def beg.loop; yield end # Just go through once, thanks. ☺
    calls = { verbose_system: [], dir_glob: [] }
    beg.stub :verbose_system, -> *args {
      calls[:verbose_system] << args
    } do
      File.stub :exists?, -> *arg {
        calls[:file_exists] = arg
        r = returns[:file_exists]
        returns[:file_exists][arg[0]]
      } do
        Dir.stub :glob, -> *args {
          calls[:dir_glob] << args
          returns[:dir_glob]
        } do
          yield beg
        end
      end
    end
    calls
  end
  def test_poor_mans
    calls = with_fake_system_interaction \
      file_exists: {'Guardfile' => false},
      dir_glob: ['lib/foo.rb'] do |beg|
      beg.run
    end
    watch_cmd, test_cmd = calls[:verbose_system]
    assert_equal 'Guardfile', calls[:file_exists][0]
    assert_equal [%w(inotifywait lib/foo.rb)], watch_cmd
    assert_equal [%w(bundle exec rake test)], test_cmd
  end

  def test_with_guardfile
    calls = with_fake_system_interaction \
      file_exists: {'Guardfile' => true} do |beg|
      beg.argv = ['--someflag']
      beg.run
    end
    watch_cmd, test_cmd = calls[:verbose_system]
    assert_equal 'Guardfile', calls[:file_exists][0]
    assert_equal [%w(bundle exec guard --someflag)], calls[:verbose_system][0]
  end
end
