require_relative '../../helper'

module Scorm2004
  module Manifest
    class NonNegativeIntegerAttributeTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'a visitor with xs:nonNegativeInteger attribute' do
        class Visitor
          include VisitorPattern
          include CustomError
          include Attributes

          attribute :non_negative_integer, 'foo'
        end

        setup do
          @v = Visitor.new
        end

        should 'raise exception when visiting an empty element' do
          assert_error do
            el('<dummy />').accept(@v)
          end
        end

        %w( 0 +21 00009 411 ).each do |valid_number|
          tag = "<dummy foo='#{valid_number}' />"
          should "accept #{tag}" do
            el(tag).accept(@v)
            assert_equal Integer(valid_number, 10), @v.foo
          end
        end

        %w( 1.000 -50 ).each do |invalid_number|
          tag = "<dummy foo='#{invalid_number}' />"
          should "raise exception when visiting #{tag}" do
            assert_error { el(tag).accept(@v) }
          end
        end

        def assert_error(&block)
          assert_raise Visitor::Error, &block
        end
      end

      context 'a visitor with xs:nonNegativeInteger attribute optional' do
        class VisitorWithOptionalAttribute
          include VisitorPattern
          include CustomError
          include Attributes

          attribute :non_negative_integer, 'bar', allow_nil: true
        end

        should 'raise nothing' do
          assert_nothing_raised do
            el('<dummy />').accept(VisitorWithOptionalAttribute.new)
          end
        end
      end
    end
  end
end
