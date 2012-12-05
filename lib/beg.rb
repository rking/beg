class Beg
  def self.cli argv
    Beg.new(argv).run
  end

  def initialize argv = []; @argv = argv end

  def run
    if File.exists? 'Guardfile'
      run_with_guardfile
    else
      run_poor_man_style
    end
  end

  def run_with_guardfile
    verbose_system %w(bundle exec guard)
  end

  def run_poor_man_style
    loop do
      verbose_system ['inotifywait'] + Dir['**/*.rb']
      verbose_system %w(bundle exec rake test)
    end
  end

  def verbose_system cmd
    puts "Running #{cmd.join ' '}"
    system *cmd
  end
end
