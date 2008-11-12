require 'rake/testtask'
require 'rake/rdoctask'

desc "Default: run tests"
task :default => :test

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
end

Rake::RDocTask.new do |d|
  d.rdoc_dir = 'doc'
  d.options = %w(-S -N -c UTF-8)
  d.main    = "README.rdoc"
  d.rdoc_files.include(d.main, "lib/**/*.rb")
end
