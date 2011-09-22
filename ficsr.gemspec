# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "ficsr/version"

Gem::Specification.new do |s|
  s.name        = "ficsr"
  s.version     = Ficsr::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Thilko Richter"]
  s.email       = [""]
  s.homepage    = ""
  s.summary     = %q{Ruby library for the free internet chess server}
  s.description = %q{Administration of games any other various thing are possible}

  s.rubyforge_project = "ficsr"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  
  s.add_development_dependency('rspec', "~> 2.6.0")
  s.add_development_dependency('autotest', "~> 4.4.6")
  s.add_development_dependency('autotest-growl', "~> 0.2.9")
  s.add_development_dependency('autotest-fsevent', "~> 0.2.5")
end
