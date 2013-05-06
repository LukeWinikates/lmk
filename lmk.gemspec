lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'lmk/version'

Gem::Specification.new do |s|
  s.name = 'lmk'
  s.summary = 'runs a command and sends the output via sms'
  s.authors = ["Luke Winikates"]
  s.version = LMK::VERSION
  s.executables << 'lmk'
  s.files = %w(LICENSE README.md lmk.gemspec)
  s.files += Dir.glob("bin/**/*")
  s.files += Dir.glob("lib/**/*.rb")
end
