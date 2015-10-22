require 'rubygems/tasks'
require 'yard'

task default: %w{build install yard update_documentation}

# make building gems easier
Gem::Tasks.new do |tasks|
  tasks.console.command = 'pry'
end

# generate YARD documentation
YARD::Rake::YardocTask.new

task :update_documentation do
  puts "Updating online documentation..."
  %x{cp -r doc/* ~/public_html/whalespeak/}
end
