require_relative '../../helper'

module Scorm2004
  module Manifest
    class SequencingRulesTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = SequencingRules.new
      end
      
      test 'an empty element' do
        assert el('<dummy />').accept(@v)
      end

      test 'an element with children' do
        condition_rule_visitor = mock()
        condition_rule_visitor.expects(:visit).times(6)
        @v.expects(:condition_rule_visitor).times(6).returns(condition_rule_visitor)
        el(<<-XML).accept(@v)
          <dummy>
            <imsss:preConditionRule /><imsss:preConditionRule />
            <imsss:postConditionRule /><imsss:postConditionRule />
            <imsss:exitConditionRule /><imsss:exitConditionRule />
          </dummy>
        XML
      end

      %w( pre_condition_rules post_condition_rules exit_condition_rules ).each do |children|
        test "a visitor responds to :#{children}" do
          assert @v.respond_to? children.intern
        end
      end
    end
  end
end
