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
        class VisitorHavingBinaryAttributesWithoutDefaultValues < Visitor
          include CustomError

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
        class VisitorHavingNamespacedAttribute < Visitor
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

      context 'visitor with a string attribute' do
        class VisitorWithStringAttribute < Visitor
          include CustomError

          attribute(:string, 'foo', spm: 10)
        end

        setup do
          @v = VisitorWithStringAttribute.new
        end

        should 'set a string value as the attribute' do
          el('<dummy foo="bar baz" />').accept(@v)
          assert_equal 'bar baz', @v.foo
        end

        should 'raise exception if the attribute not found' do
          assert_raise VisitorWithStringAttribute::Error do
            el('<dummy />').accept(@v)
          end
        end

        should 'raise exception if the length of string exceeds the SPM' do
          assert_raise VisitorWithStringAttribute::Error do
            el('<dummy foo="0123456789ABCDEF" />').accept(@v)
          end
        end
      end

      context 'visitor with an id attribute' do
        class VisitorWithIdAttribute < Visitor
          include CustomError

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
        class VisitorHavingDecimalAttributeWithoutDefaultValue < Visitor
          include CustomError

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
        class VisitorHavingDecimalAttributeWithRange < Visitor
          include CustomError

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

      context 'visitor having a token attribute' do
        class VisitorHavingTokenAttribute < Visitor
          include CustomError

          attribute :token, 'foo', vocabulary: %w( foo bar baz )
        end
        
        setup do
          @v = VisitorHavingTokenAttribute.new
        end

        context 'visiting an element without the attribute' do
          should 'raise exception' do
            assert_raise VisitorHavingTokenAttribute::Error do
              el('<dummy />').accept(@v)
            end
          end
        end

        context 'visiting an element with a valid token attribute' do
          should 'set the token as the value of the attribute' do
            el('<dummy foo="bar" />').accept(@v)
            assert_equal 'bar', @v.foo
          end
        end

        context 'visiting an element with an invalid token attribute' do
          should 'raise exception' do
            assert_raise VisitorHavingTokenAttribute::Error do
              el('<dummy foo="hoge" />').accept(@v)
            end
          end
        end
      end
    end
  end
end

#  LocalWords:  AttributesTest PartialManifest VisitorPattern defaultsTrue el
#  LocalWords:  VisitorHavingBinaryAttributesWithDefaultValues defaultsFalse
#  LocalWords:  VisitorHavingBinaryAttributesWithoutDefaultValues CustomError
#  LocalWords:  VisitorHavingNamespacedAttribute adlcp unnamespaced spm baz
#  LocalWords:  VisitorWithStringAttribute VisitorWithIdAttribute whitespaces
#  LocalWords:  VisitorHavingDecimalAttributeWithDefaultValue
#  LocalWords:  VisitorHavingDecimalAttributeWithoutDefaultValue
#  LocalWords:  VisitorHavingDecimalAttributeWithRange
