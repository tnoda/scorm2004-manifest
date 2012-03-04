require_relative '../../helper'

module Scorm2004
  module Manifest
    class RuleConditionsTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RuleConditions.new
        @v.stubs(:rule_condition_visitor).returns(stub(:visit))
      end
      
      test 'a visitor set the default value as its attribute' do
        el('<dummy><imsss:ruleCondition /></dummy>').accept(@v)
        assert_equal 'all', @v.condition_combination
      end

      test 'a visitor visits its children' do
        rule_condition_visitor = mock()
        rule_condition_visitor.expects(:visit).twice
        @v.expects(:rule_condition_visitor).twice.returns(rule_condition_visitor)
        assert el(<<-XML).accept(@v)
          <dummy>
            <imsss:ruleCondition />
            <imsss:ruleCondition />
          </dummy>  
        XML
      end

      test 'an element without any <ruleCondition>s causes error' do
        assert_raise RuleConditions::Error do
          el('<dummy />').accept(@v)
        end
      end
    end
  end
end
