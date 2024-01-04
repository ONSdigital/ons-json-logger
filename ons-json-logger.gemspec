# frozen_string_literal: true

require_relative 'lib/ons-json-logger/version'

Gem::Specification.new do |s|
  s.name                  = 'ons-json-logger'
  s.version               = ONSJSONLogger::VERSION
  s.summary               = 'A class for generating structured JSON log entries.'
  s.description           = <<~DESC
    A utility class for generating structured JSON log entries with optional additional fields suitable for web applications.
  DESC
  s.authors               = ['John Topley']
  s.email                 = ['john.topley@ons.gov.uk']
  s.files                 = ['README.md']
  s.files                += Dir['lib/**/*.rb']
  s.homepage              = 'https://github.com/ONSdigital/ons-json-logger'
  s.license               = 'MIT'
  s.required_ruby_version = '>= 3.1.0'
  s.metadata['rubygems_mfa_required'] = 'true'
end
