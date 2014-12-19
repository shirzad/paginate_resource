require "bundler/gem_tasks"


require 'rake/testtask'
require 'rdoc/task'

Rake::TestTask.new(:test) do |t|
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
  t.libs << 'test'
end

# Make test the default task.
task :default => :test