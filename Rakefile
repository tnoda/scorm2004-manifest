# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "scorm2004-manifest"
  gem.homepage = "http://github.com/tnoda/scorm2004-manifest"
  gem.license = "MIT"
  gem.summary = %Q{A manifest file parser/validator library for SCORM 2004}
  gem.description = %Q{scorm2004-manifest is a parser/validator library for SCORM 2004 manifest files. It currently supports SCORM 2004 4th Edition Content Aggregation Model (CAM) Version 1.1.}
  gem.email = "takahiro.noda+rubygems@gmail.com"
  gem.authors = ["Takahiro Noda"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :default => :test

require 'yard'
YARD::Rake::YardocTask.new
