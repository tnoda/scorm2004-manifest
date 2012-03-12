require 'pathname'
require 'open-uri'

module FunctionalTest
  @@tmpdir = Pathname('../tmp')

  def self.included(base)
    base.extend ClassMethods
  end

  def xml
    File.exists?(cache_path) ? open(cache_path) : download
  end

  def gist_url
    "https://raw.github.com/gist/#{gist_id}/imsmanifest.xml"
  end

  def download
    File.open(cache_path, 'wb') do |f|
      f.write open(gist_url, proxy: ENV['http_proxy']).read
    end
  end

  def cache_path
    create_tmpdir + "#{nickname}.xml"
  end

  def create_tmpdir
    if File.exist?(@@tmpdir) && File.directory?(@@tmpdir)
      @@tmpdir
    else
      Pathname(FileUtils.mkdir_p(tmpdir).first)
    end
  end

  module ClassMethods
    attr_reader :gist_id, :nickname

    def gist(gist_id, nickname)
      define_method(:gist_id) { gist_id }
      define_method(:nickname) { nickname }
    end
  end
end
