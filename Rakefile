require "bundler/gem_tasks"
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

desc "Run tests"
task :default => :test

desc "Build lagotto-rb docs"
task :docs do
	system "yardoc"
end

desc "bundle install"
task :b do
  system "bundle install"
end

desc "clean out builds"
task :clean do
  system "ls | grep [0-9].gem | xargs rm"
end

desc "Build lagotto-rb"
task :build do
	system "gem build lagotto-rb.gemspec"
end

desc "Install lagotto-rb"
task :install => :build do
	system "gem install lagotto-rb-#{Lagotto::VERSION}.gem"
end

desc "Release to Rubygems"
task :release => :build do
  system "gem push lagotto-rb-#{Lagotto::VERSION}.gem"
end
