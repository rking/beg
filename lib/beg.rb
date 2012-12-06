class Beg
  attr_accessor :argv

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
    verbose_system %w(bundle exec guard) + @argv
  end

  def run_poor_man_style
    loop do
      verbose_system ['inotifywait'] + Dir.glob('**/*.rb')
      verbose_system %w(bundle exec rake test)
    end
  end

  def verbose_system cmd
    str = color 36, cmd.join(' ')
    puts "Running: " + str
    system *cmd
  end

  def color num, str
    "\e[%dm%s\e[0m" % [num, str]
  end
end
