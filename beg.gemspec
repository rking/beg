# encoding: utf-8
Gem::Specification.new do |gem|
  gem.name = 'beg'
  gem.homepage = 'http://github.com/rking/beg'
  gem.summary = "'bundle exec guard' plus bonus features (mostly TΟDO)"
  gem.description = 'Run a guard-like loop without a Guardfile, or Guard if there is one'
  gem.version = '0.0.3'
  gem.license = 'CC0'
  gem.email = 'beg@sharpsaw.org'
  gem.authors = %w(☈king)

  gem.files = `git ls-files`.split $/
  gem.executables = gem.files.grep(%r{^bin/}).map{ |f| File.basename f }
  gem.test_files = gem.files.grep %r{^(test|spec|features)/}
  gem.require_paths = %w(lib)
  gem.add_dependency 'guard'
  gem.add_development_dependency 'working'
end
