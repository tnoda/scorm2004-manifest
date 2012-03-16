require_relative '../../helper'

module Scorm2004
  module Manifest
    class StringAttributeTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'a visitor for an element with a string attribute' do
        class SimpleVisitor
          include VisitorPattern
          include Attributes

          attribute :string, 'foo'
        end

        setup do
          @v = SimpleVisitor.new
        end

        should 'set the string value as its attribute' do
          el('<dummy foo="bar baz" />').accept(@v)
          assert_equal 'bar baz', @v.foo
        end

        should 'raise exception if the attribute does not exist' do
          assert_raise SimpleVisitor::Error do
            el('<dummy />').accept(@v)
          end
        end
      end

      context 'a visitor having SPM' do
        class SpmVisitor
          include VisitorPattern
          include Attributes

          attribute :string, 'foo', spm: 10
        end

        should 'raise exception if the value exceeds the SPM' do
          @v = SpmVisitor.new
          assert_raise SpmVisitor::Error do
            el('<dummy foo="' + 'x' * 11 + '" />').accept(@v)
          end
        end
      end

      context 'a visitor for an element with a string attribute optional' do
        class OptionalVisitor
          include VisitorPattern
          include Attributes

          attribute :string, 'foo', allow_nil: true
        end

        should 'not raise exception' do
          @v = OptionalVisitor.new
          assert_nothing_raised do
            el('<dummy />').accept(@v)
          end
        end
      end
    end
  end
end
