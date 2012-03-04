require_relative '../../helper'

module Scorm2004
  module Manifest
    class RuleConditionTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RuleCondition.new
      end
      
      test 'an empty element causes error' do
        assert_error do
          el('<dummy />').accept(@v)
        end
      end

      test 'a visitor sets default operator value' do
        el('<dummy condition="always" />').accept(@v)
        assert_equal 'noOp', @v.operator
      end

      [-1.0, 0.0, 1.0].each do |valid_measure_threshold|
        test "valid measure threshold: #{valid_measure_threshold}" do
          el("<dummy measureThreshold='#{valid_measure_threshold}' condition='always' />").accept(@v)
          assert_equal valid_measure_threshold, @v.measure_threshold
        end
      end

      [-1.0001, 1.0001].each do |invalid_measure_threshold|
        test "invalid measure threshold: #{invalid_measure_threshold}" do
          assert_error do
            el("<dummy measureThreshold='#{invalid_measure_threshold}' condition='always' />").accept(@v)
          end
        end
      end

      Scorm2004::Manifest::RuleCondition::VOCABULARY.each do |token|
        test "valid condition token: #{token}" do
          el("<dummy condition='#{token}' />").accept(@v)
          assert_equal token, @v.condition
        end
      end

      test 'invalid condition token causes error' do
        assert_error do
          el('<dummy condition="invalid" />').accept(@v)
        end
      end

      test 'The referencedObjective attribute cannot be an empty string' do
        assert_error do
          el('<dummy referencedObjective="" condition="always" />').accept(@v)
        end
      end

      [" ", "\t", "\n", "\r" ].each do |whitespace|
        test "The referencedObjective cannot contain #{whitespace.dump}" do
          assert_error do
            el("<dummy referencedObjective='foo#{whitespace}bar' condition='always' />").accept(@v)
          end
        end
      end

      def assert_error(&block)
        assert_raise RuleCondition::Error, &block
      end
    end
  end
end
