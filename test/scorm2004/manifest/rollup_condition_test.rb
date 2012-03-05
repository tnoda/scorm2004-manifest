require_relative '../../helper'

module Scorm2004
  module Manifest
    class RollupConditionTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RollupCondition.new
      end
      
      test 'an empty element causes error' do
        assert_error { el.accept(@v) }
      end

      test 'the operator attribute defaults noOp' do
        el('<dummy condition="satisfied" />').accept(@v)
        assert_equal 'noOp', @v.operator
      end

      RollupCondition::CONDITIONS.each do |condition|
        tag = "<dummy condition='#{condition}' />"
        test tag do
          el(tag).accept(@v)
          assert_equal condition, @v.condition
        end
      end

      test 'an invalid operator causes error' do
        assert_error { el('<dummy condition="satisfied" operator="invalid" />').accept(@v) }
      end

      test 'an invalid condition causes error' do
        assert_error { el('<dummy condition="invalid" />').accept(@v) }
      end

      def assert_error(&block)
        assert_raise RollupCondition::Error, &block
      end
    end
  end
end
