lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'lmk/version'

Gem::Specification.new do |s|
  s.name = 'lmk'
  s.homepage = 'http://www.lukewinikates.com/lmk'
  s.description = s.summary = 'runs a command and sends the output via sms'
  s.authors = ["Luke Winikates"]
  s.version = LMK::VERSION
  s.executables << 'lmk'
  s.add_dependency 'thor'
  s.add_dependency 'twilio-ruby'
  s.add_dependency 'popen4'
  s.add_dependency 'octokit'
  s.add_dependency 'hashie'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.files = %w(LICENSE README.md lmk.gemspec)
  s.files += Dir.glob("bin/**/*")
  s.files += Dir.glob("lib/**/*.rb")
end
