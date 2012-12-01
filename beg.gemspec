# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name = 'beg'
  gem.homepage = 'http://github.com/rking/beg'
  gem.summary = "'bundle exec guard' plus bonus features (mostly TODO)"
  gem.description = 'Run a guard-like loop without a Guardfile'
  gem.version = '0.0.1'
  gem.license = 'CC0'
  gem.email = 'beg@sharpsaw.org'
  gem.authors = %w(☈king)

  gem.files = `git ls-files`.split $/
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename f }
  gem.test_files = gem.files.grep %r{^(test|spec|features)/}
  gem.require_paths = %w(lib)
  %w(pry-de guard).each do |dep| gem.add_dependency dep end
end
