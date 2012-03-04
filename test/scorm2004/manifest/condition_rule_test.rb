require_relative '../../helper'

module Scorm2004
  module Manifest
    class ConditionRuleTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = ConditionRule.new
      end
      
      test 'a visitor visits children' do
        @v.expects(:rule_conditions_visitor).once.returns(mock(:visit))
        @v.expects(:rule_action_visitor).once.returns(mock(:visit))
        el(<<-XML).accept(@v)
          <dummy>
            <imsss:ruleConditions />
            <imsss:ruleAction />
          </dummy>
        XML
      end

      test 'an element without <ruleConditions> causes error' do
        assert_error do
          el('<dummy><imsss:ruleAction /></dummy>').accept(@v)
        end
      end

      test 'an element without <ruleAction> causes error' do
        assert_error do
          el('<dummy><imsss:ruleCondition></dummy>').accept(@v)
        end
      end

      def assert_error(&block)
        assert_raise ConditionRule::Error, &block
      end
    end
  end
end
