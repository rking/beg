# More info at https://github.com/guard/guard#readme
guard 'minitest' do
  # with Minitest::Unit
  watch %r|^test/.*_test\.rb|
  watch %r|^lib/(.*)\.rb| do |m| "test/#{m[1]}_test.rb" end
  watch %r|^test/test_helper\.rb| do 'test' end
end
# vim:ft=ruby
