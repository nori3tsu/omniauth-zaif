# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-zaif/version"

Gem::Specification.new do |s|
  s.name        = "omniauth-zaif"
  s.version     = OmniAuth::Zaif::VERSION
  s.authors     = ["nori3tsu"]
  s.email       = ["tugend.licht@gmail.com"]
  s.homepage    = "https://github.com/nori3tsu/omniauth-zaif"
  s.description = %q{OmniAuth strategy for Zaif}
  s.summary     = s.description
  s.license     = "MIT"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency 'json', '~> 1.3'
  s.add_dependency 'omniauth-oauth2', '~>1.3.1'
  s.add_development_dependency 'bundler', '~> 1.0'
end
