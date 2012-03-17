module Scorm2004
  module Manifest
    class ConditionRule
      include VisitorPattern
      include Children

      # @attribute [r] rule_conditions
      # @return [RuleConditions] <imsss:ruleConditions>
      has_one_and_only_one 'imsss:ruleConditions'

      # @attribute [r] rule_action
      # @return [RuleAction] <imsss:ruleAction>
      has_one_and_only_one 'imsss:ruleAction'
    end
  end
end
