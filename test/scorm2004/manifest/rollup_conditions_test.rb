require_relative '../../helper'

module Scorm2004
  module Manifest
    class RollupConditionsTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RollupConditions.new
        @v.stubs(:rollup_condition_visitor).returns(stub(:visit))
      end
      
      test 'an empty element causes error' do
        assert_error { el.accept(@v) }
      end

      test 'default conditionCombination' do
        el('<dummy><imsss:rollupCondition /></dummy>').accept(@v)
        assert_equal 'any', @v.condition_combination
      end

      %w( all any ).each do |valid_condition_combination|
        tag = "<dummy conditionCombination='#{valid_condition_combination}'><imsss:rollupCondition /></dummy>"
        test tag do
          el(tag).accept(@v)
          assert_equal valid_condition_combination, @v.condition_combination
        end
      end

      test 'invalid conditionCombination' do
        assert_error do
          el('<dummy conditionCombination="invalid"><imsss:rollupCondition /></dummy>').accept(@v)
        end
      end

      test 'a visitor visit multiple children' do
        rollup_condition_visitor = mock()
        rollup_condition_visitor.expects(:visit).twice
        @v.expects(:rollup_condition_visitor).twice.returns(rollup_condition_visitor)
        el(<<-XML).accept(@v)
          <dummy>
            <imsss:rollupCondition />
            <imsss:rollupCondition />
          </dummy>
        XML
      end

      def assert_error(&block)
        assert_raise RollupConditions::Error, &block
      end
    end
  end
end
