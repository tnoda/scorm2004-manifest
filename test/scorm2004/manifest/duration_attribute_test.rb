require_relative '../../helper'

module Scorm2004
  module Manifest
    class DurationAttributeTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'an visitor with a duration attribute' do
        class Visitor
          include VisitorPattern
          include CustomError
          include Attributes

          attribute :duration, 'foo'
        end

        setup do
          @v = Visitor.new
        end

        should 'raise exception when visiting an empty element' do
          assert_error { el('<dummy />').accept(@v) }
        end

        %w( PT1004199059S PT130S PT2M10S P1DT2S -P1Y P1Y2M3DT5H20M30.123S ).each do |valid_duration|
          tag = "<dummy foo='#{valid_duration}' />"
          should "accept #{tag}" do
            el(tag).accept(@v)
            assert_equal valid_duration, @v.foo
          end
        end

        %w( 1Y P1S P-1Y P1M2Y P1Y-1M ).each do |invalid_duration|
          tag = "<dumm foo='#{invalid_duration}' />"
          should "reject #{tag}" do
            assert_error { el(tag).accept(@v )}
          end
        end

        def assert_error(&block)
          assert_raise Visitor::Error, &block
        end
      end

      context 'an visitor with a duration attribute optional' do
        class VisitorWithOptionalAttribute
          include VisitorPattern
          include Attributes

          attribute :duration, 'bar', allow_nil: true
        end

        should 'raise nothing' do
          assert_nothing_raised { el('<dummy />').accept(VisitorWithOptionalAttribute.new) }
        end
      end
    end
  end
end
