require_relative '../../helper'

module Scorm2004
  module Manifest
    class AttributesTest < ActiveSupport::TestCase
      include PartialManifest
      
      class Visitor
        include VisitorPattern
        include Attributes
      end

      context 'visitor having binary attributes with default values' do
        class VisitorHavingBinaryAttributesWithDefaultValues < Visitor
          attribute(:boolean, 'defaultsTrue', default: true)
          attribute(:boolean, 'defaultsFalse', default: false)
        end

        setup do
          @v = VisitorHavingBinaryAttributesWithDefaultValues.new
        end

        should 'set default values' do
          el('<dummy />').accept(@v)
          assert_equal true, @v.defaults_true
          assert_equal false, @v.defaults_false
        end

        should 'set boolean values' do
          el('<dummy defaultsTrue="false" defaultsFalse="true" />').accept(@v)
          assert_equal false, @v.defaults_true
          assert_equal true, @v.defaults_false
        end
      end

      context 'visitor having binary attributes without default values' do
        class VisitorHavingBinaryAttributesWithoutDefaultValues
          include VisitorPattern
          include Attributes

          attribute(:boolean, 'foo')
          attribute(:boolean, 'bar')
        end

        setup do
          @v = VisitorHavingBinaryAttributesWithoutDefaultValues.new
        end

        should 'raise exception if the attribute not found' do
          assert_raise VisitorHavingBinaryAttributesWithoutDefaultValues::Error do
            el('<dummy foo="true" />').accept(@v)
          end
        end
      end

      context 'visitor having a attribute with namespace prefix' do
        class VisitorHavingNamespacedAttribute
          include VisitorPattern
          include Attributes

          attribute(:boolean, 'adlcp:foo')
        end

        setup do
          @v = VisitorHavingNamespacedAttribute.new
        end

        should 'create an unnamespaced attribute' do
          el('<dummy adlcp:foo="false" />').accept(@v)
          assert_equal false, @v.foo
        end
      end

      context 'visitor with an id attribute' do
        class VisitorWithIdAttribute
          include VisitorPattern
          include Attributes

          attribute(:id, 'foo')
        end

        setup do
          @v = VisitorWithIdAttribute.new
        end

        should 'set a string value as the attribute' do
          el('<dummy foo="bar" />').accept(@v)
          assert_equal 'bar', @v.foo
        end

        should 'raise exception unless the attribute exists' do
          assert_raise VisitorWithIdAttribute::Error do
            el('<dummy />').accept(@v)
          end
        end

        whitespaces = {
          'space'   => ' ',
          'tab'     => "\t",
          'newline' => "\n",
          'return'  => "\r"
        }
        whitespaces.each do |k, v|
          should "raise exception if the attribute value contains a #{k}" do
            assert_raise VisitorWithIdAttribute::Error do
              el("<dummy foo='bar#{v}baz' />").accept(@v)
            end
          end
        end

        should 'raise exception if the attribute value consists of digits' do
          assert_nothing_raised do
            el('<dummy foo="4bar2baz6" />').accept(@v)
          end

          assert_raise VisitorWithIdAttribute::Error do
            el('<dummy foo="123456789" />').accept(@v)
          end
        end
      end

      context 'visitor having a decimal attribute without a default value' do
        class VisitorHavingDecimalAttributeWithoutDefaultValue
          include VisitorPattern
          include Attributes

          attribute(:decimal, 'foo')
        end

        setup do
          @v = VisitorHavingDecimalAttributeWithoutDefaultValue.new
        end

        should 'raise exception unless the attribute exists' do
          assert_raise VisitorHavingDecimalAttributeWithoutDefaultValue::Error do
            el('<dummy />').accept(@v)
          end
        end

        should 'set a float value' do
          el('<dummy foo="6.789" />').accept(@v)
          assert_equal 6.789, @v.foo
        end
      end

      context 'visitor having a decimal attribute with a default value' do
        class VisitorHavingDecimalAttributeWithDefaultValue < Visitor
          attribute(:decimal, 'foo', default: -1.234)
        end

        setup do
          @v = VisitorHavingDecimalAttributeWithDefaultValue.new
        end

        should 'set a default value' do
          el('<dummy />').accept(@v)
          assert_equal -1.234, @v.foo
        end

        should 'set a float value' do
          el('<dummy foo="45.67" />').accept(@v)
          assert_equal 45.67, @v.foo
        end
      end

      context 'visitor having a decimal attribute with a range' do
        class VisitorHavingDecimalAttributeWithRange
          include VisitorPattern
          include Attributes

          attribute(:decimal, 'foo', range: -1.0..1.0)
        end

        setup do
          @v = VisitorHavingDecimalAttributeWithRange.new
        end

        should 'set a float value if the value is within the range' do
          [-1.0, 0.0, 1.0].each do |v|
            el("<dummy foo='#{v}' />").accept(@v)
            assert_equal v, @v.foo, v
          end
        end

        should 'raise exception if the value is out of the range' do
          [-1.0001, 1.0001].each do |v|
            assert_raise VisitorHavingDecimalAttributeWithRange::Error do
              el("<dummy foo='#{v}' />").accept(@v)
            end
          end
        end
      end

      context 'visitor having an idref attribute' do
        class VisitorHavingIdrefAttribute
          include VisitorPattern
          include Attributes

          attribute :idref, 'foo'
        end

        setup do
          @v = VisitorHavingIdrefAttribute.new
        end

        context 'visitng an element with an idref attribute' do
          should 'set the idref value ast its attribute' do
            el('<dummy foo="bar" />').accept(@v)
            assert_equal 'bar', @v.foo
          end
        end

        context 'visiting an element without an idref attribute' do
          should 'raise exception' do
            assert_raise VisitorHavingIdrefAttribute::Error do
              el('<dummy />').accept(@v)
            end
          end
        end
      end
    end
  end
end
