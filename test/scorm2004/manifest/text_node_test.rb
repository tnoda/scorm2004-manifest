require_relative '../../helper'

module Scorm2004
  module Manifest
    class TextNodeTest < ActiveSupport::TestCase
      include PartialManifest
      
      class Visitor
        include VisitorPattern
        include TextNode
      end

      setup do
        @v = Visitor.new
        el('<dummy>hello world</dummy>').accept(@v)
      end

      context 'a visitor that includes the TextNode module' do
        should 'respond_to :content' do
          assert @v.respond_to? :content
        end

        should 'respond_to :to_s' do
          assert @v.respond_to? :to_s
        end

        should 'alias :to_s :content' do
          assert_equal @v.to_s, @v.content
        end

        should 'alias :to_str :content'do
          assert_equal @v.to_str, @v.content
        end
      end
    end
  end
end
