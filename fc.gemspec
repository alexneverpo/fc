# frozen_string_literal: true

require_relative 'lib/fc/version'

Gem::Specification.new do |spec|
  spec.name          = 'fc'
  spec.version       = FC::VERSION
  spec.authors       = ['alexneverpo']
  spec.email         = ['alexneverpo@outlook.com']

  spec.summary       = 'A simple file catalog helper.'
  spec.description   = 'Simple but fast.'
  spec.homepage      = 'https://github.com/alexneverpo/fc'
  spec.license       = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.3.0')

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'rspec', '~> 3.9'
  spec.add_development_dependency 'rubocop', '~> 0.92.0'
  spec.add_development_dependency 'rubocop-rspec', '~> 1.43', '>= 1.43.2'
  spec.add_development_dependency 'ruby_jard', '~> 0.3.1'
end
