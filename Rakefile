require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.verbose = true
end

task :default => :test

desc 'Console mode'
task :console do
  require 'irb'
  require 'author'
  ARGV.clear
  IRB.start
end
