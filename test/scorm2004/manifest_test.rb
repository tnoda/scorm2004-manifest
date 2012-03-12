require_relative '../helper'

module Scorm2004
  class ManifestTest < ActiveSupport::TestCase
    context 'Manifest' do
      should 'be a module' do
        assert_kind_of Module, Manifest
      end

      should 'have its own exception class' do
        assert_kind_of StandardError, Manifest::Error.new
      end

      should 'have its own namespace as a Hash' do
        assert_kind_of Hash, Manifest::NS
      end
    end

    context 'Manifest()' do
      should 'call Manifest.parse' do
        Scorm2004::Manifest.expects(:parse)
        Scorm2004::Manifest :dummy
      end
    end

    context 'Manifest.parse()' do
      should 'let a manifest visitor visit a root element' do
        Scorm2004::Manifest::Manifest.expects(:new).returns(mock(:visit))
        Scorm2004::Manifest.parse('<dummy />')
      end
    end
  end
end
