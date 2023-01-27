# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'binger/version'

Gem::Specification.new do |spec|
  spec.name          = 'binger'
  spec.version       = Binger::VERSION
  spec.authors       = ['Thomas Deranek']
  spec.email = ['tderanek117@gmail.com']

  spec.summary = 'Automates daily searches for Microsoft Rewards'
  spec.description = 'Pronounced "bing-er". Automates daily searches for Microsoft Rewards'
  spec.homepage      = 'https://github.com/tderanek/binger/blob/master/README.md.'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split("\n").reject { |f| f.match(%r{^spec/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  # spec.add_dependency 'selenium-webdriver', '~> 4.0.0.beta1'
  spec.add_dependency 'thor', '~> 0.20'
  spec.add_dependency 'watir', '~> 7.0.0.beta5'
  spec.add_dependency 'webdriver-user-agent', '~> 7.6'
  spec.add_dependency 'psych', '~> 3.0'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.57'
end
