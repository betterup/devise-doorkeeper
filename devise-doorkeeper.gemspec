# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'devise/doorkeeper/version'

Gem::Specification.new do |spec|
  spec.name          = 'devise-doorkeeper'
  spec.version       = Devise::Doorkeeper::VERSION
  spec.authors       = ['BetterUp']
  spec.email         = ['developers@betterup.co']
  spec.summary       = %q{ Integrate Doorkeeper OAuth2 tokens into Devise applications }
  spec.description   = %q{ Support authentication via OAuth2 tokens dispensed from the Doorkeeper authorization flow }
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'rails', '~> 5.0.0'
  spec.add_dependency 'devise', '~> 4.7.3'
  spec.add_dependency 'doorkeeper', '~> 5.5'

  spec.add_development_dependency 'bundler', '~> 1.17.3'
  spec.add_development_dependency 'rspec-rails', '~> 4.0.2'
  spec.add_development_dependency 'factory_bot_rails', '~> 4.9'
  spec.add_development_dependency 'factory_girl_rspec', '~> 3.0.0'
  spec.add_development_dependency 'faker', '~> 2.16.0'
  spec.add_development_dependency 'json_spec', '~> 1.1.4'
  spec.add_development_dependency 'sqlite3', '~> 1.3.11'
  spec.add_development_dependency 'coveralls', '~> 0.8.15'
  spec.add_development_dependency 'pry', '~> 0.14.0'
  spec.add_development_dependency 'rake', '~> 13.0.3'
  spec.add_development_dependency 'travis', '~> 1.10.0'

  # configure gem version for continuous integration builds
  if ENV['TRAVIS_JOB_NUMBER']
    spec.version = "#{spec.version}.ci.#{ENV['TRAVIS_JOB_NUMBER']}"
  end
end
