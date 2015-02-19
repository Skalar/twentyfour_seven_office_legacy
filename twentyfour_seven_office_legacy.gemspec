# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'twentyfour_seven_office_legacy/version'

Gem::Specification.new do |spec|
  spec.name          = "twentyfour_seven_office_legacy"
  spec.version       = TwentyfourSevenOfficeLegacy::VERSION
  spec.authors       = ["Peter Skeide"]
  spec.email         = ["ps@skalar.no"]
  spec.summary       = %q{Client libaray for integrating with the 24SevenOffice legacy web services}
  spec.homepage      = "http://github.com/skalar/twentyfour_seven_office_legacy"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"

  spec.add_dependency "savon", "~> 2.8"
end
