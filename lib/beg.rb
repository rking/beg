class Beg
  def self.cli argv
    loop do
      system 'inotifywait', *Dir['**/*.rb']
      cmd = %w(bundle exec rake test)
      puts "Running #{cmd}"
      system cmd
    end
  end
end
