require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec) do
  |t| t.rspec_opts =  "--tag ~integration"
end

RSpec::Core::RakeTask.new(:integration) do |t|
  t.rspec_opts = "--tag integration"
end

task :default => :spec
task :all => [:spec, :integration] 
