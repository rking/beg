class Beg
  def self.cli argv
    while system 'inotifywait', '-e', 'modify', Dir['**/*.rb']
      cmd = %w(bundle exec rake test)
      puts "Running #{cmd}"
      system cmd
    end
  end
end
