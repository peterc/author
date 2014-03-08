$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'author'
  s.version     = '0.0.1'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Peter Cooper']
  s.email       = ['git@peterc.org']
  s.homepage    = 'https://github.com/peterc/author'
  s.summary     = %q{}
  s.description = %q{}

  s.add_development_dependency 'minitest', '>= 5.0'
  #s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'rake'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']
end
