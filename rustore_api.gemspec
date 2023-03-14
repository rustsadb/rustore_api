# frozen_string_literal: true

require File.expand_path('lib/rustore_api/version', __dir__)

Gem::Specification.new do |spec|
  spec.name = 'rustore_api'
  spec.version = RustoreApi::VERSION
  spec.authors = ['Rustem Sadykov']
  spec.email = ['rustem.sadboy@gmail.com']
  spec.summary = 'Rustore api integration for Ruby on Rails'
  spec.description = 'This gem allows to integrate Rustore api in your Rails app or simple Ruby app.'
  spec.homepage = 'https://github.com/rustsadb/rustore_api'
  spec.license = 'MIT'
  spec.platform = Gem::Platform::RUBY
  spec.required_ruby_version = '>= 2.7.0'

  spec.files = Dir[File.join('lib', '**', '*')]

  spec.extra_rdoc_files = ['README.md']

  spec.add_dependency 'activesupport'
  spec.add_dependency 'faraday', '~> 2.5'
  spec.add_dependency 'hashie'
  spec.add_dependency 'oj', '~> 3.14'
  spec.add_development_dependency 'dotenv', '~> 2.5'
  spec.add_development_dependency 'pry', '~> 0.14'
  spec.add_development_dependency 'rails', '~> 7.0'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.6'
  spec.add_development_dependency 'rubocop', '~> 1.47'
  spec.add_development_dependency 'rubocop-performance', '~> 1.16'
  spec.add_development_dependency 'rubocop-rspec', '~> 2.19'
  spec.add_development_dependency 'vcr', '~> 6.0'
  spec.add_development_dependency 'webmock', '~> 3.14'
  spec.metadata['rubygems_mfa_required'] = 'true'
end
