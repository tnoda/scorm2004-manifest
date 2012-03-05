require_relative '../../helper'

module Scorm2004
  module Manifest
    class PartialManifestTest < ActiveSupport::TestCase
      class DummyVisitor
        include PartialManifest
      end

      context 'Partial manifest of a dummy element' do
        setup do
          @el = DummyVisitor.new.el('<dummy />')
        end

        should 'be named dummy' do
          assert_equal 'dummy', @el.name
        end

        should 'be a Nokogiri node' do
          assert_kind_of Nokogiri::XML::Node, @el
        end
      end

      context 'Partial manifest of nil' do
        setup do
          @el = DummyVisitor.new.el(nil)
        end

        should 'be nil' do
          assert_nil @el
        end
      end

      context 'default partial manifest' do
        should 'return an empty element' do
          el = DummyVisitor.new.el
          assert_kind_of Nokogiri::XML::Node, el
          assert_equal 'dummy', el.name
        end
      end
    end
  end
end

