require_relative '../../helper'

module Scorm2004
  module Manifest
    class RollupRuleTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RollupRule.new
        @v.stubs(:rollup_conditions_visitor).returns(stub(:visit))
        @v.stubs(:rollup_action_visitor).returns(stub(:visit))
      end
      
      test 'an empty element causes error' do
        assert_error { el.accept @v }
      end

      test 'a visitor should visit children' do
        @v = RollupRule.new
        rollup_conditions_visitor = mock()
        rollup_conditions_visitor.expects(:visit)
        @v.expects(:rollup_conditions_visitor).returns(rollup_conditions_visitor)
        rollup_action_visitor = mock()
        rollup_action_visitor.expects(:visit)
        @v.expects(:rollup_action_visitor).returns(rollup_action_visitor)
        el(<<-XML).accept @v
          <dummy>
            <imsss:rollupConditions />
            <imsss:rollupAction />
          </dummy>
        XML
      end

      test 'a visitor sets default values' do
        el(<<-XML).accept @v
          <dummy>
            <imsss:rollupConditions />
            <imsss:rollupAction />
          </dummy>
        XML
        assert_equal 'all', @v.child_activity_set
        assert_equal 0, @v.minimum_count 
        assert_equal 0.0, @v.minimum_percent
      end

      RollupRule::CONDITIONS.each do |token|
        test "childActivitySet = '#{token}'" do
          el(<<-XML).accept @v
            <dummy childActivitySet='#{token}'>
              <imsss:rollupConditions />
              <imsss:rollupAction />
            </dummy>
          XML
          assert_equal token, @v.child_activity_set
        end
      end

      0.upto(10) do |n|
        test "minimumCount = '#{n}'" do
          el(<<-XML).accept @v
            <dummy minimumCount='#{n}'>
              <imsss:rollupConditions />
              <imsss:rollupAction />
            </dummy>
          XML
          assert_equal n, @v.minimum_count
        end
      end

      [0.0, 0.5, 1.0].each do |percent|
        test "minimumPercent = '#{percent}'" do
          el(<<-XML).accept @v
            <dummy minimumPercent='#{percent}'>
              <imsss:rollupConditions />
              <imsss:rollupAction />
            </dummy>
          XML
          assert_equal percent, @v.minimum_percent
        end
      end

      def assert_error(&block)
        assert_raise RollupRule::Error, &block
      end
    end
  end
end
