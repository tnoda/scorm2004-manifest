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
  gem.homepage = "https://github.com/tnoda/scorm2004-manifest"
  gem.license = "MIT"
  gem.summary = %Q{A manifest file parser/validator for SCORM 2004 4th Edition}
  gem.description = <<EOS
scorm2004-manifest is a Ruby gem that provides a manifest file parser for SCORM 2004 4th edition. It parses and validates the manifest file according to SCORM 2004 4th Edition Content Aggregation Model (CAM) Version 1.1. After parsing and validating, it builds an object tree that captures XML's hierarchical structure.
EOS
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
