module Scorm2004
  module Manifest
    class SequencingRules
      include VisitorPattern
      include Children

      # @attribute pre_condition_rules
      # @return [Array<ConditionRule>] <imsss:preConditionRule>
      has_zero_or_more 'imsss:preConditionRule',  visitor: :condition_rule

      # @attribute post_condition_rule
      # @return [Array<ConditionRule>] <imsss:postConditionRule>
      has_zero_or_more 'imsss:postConditionRule', visitor: :condition_rule

      # @attribute exit_condition_rule
      # @return [Array<ConditionRule>] <imsss:exitConditionRule>
      has_zero_or_more 'imsss:exitConditionRule', visitor: :condition_rule
    end
  end
end
