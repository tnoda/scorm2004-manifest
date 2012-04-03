module Scorm2004
  module Manifest
    class RuleConditions
      include VisitorPattern
      include Children
      include Attributes

      # @attribute [r] condition_combination
      # @return [String] The +conditionCombination+ attribute of <ruleConditions>
      attribute :token, 'conditionCombination', vocabulary: %w( all any ), default: 'all'

      # @attribute [r] rule_conditions
      # @return [Array<RuleCondition>] <imsss:ruleCondition>
      has_one_or_more 'imsss:ruleCondition'
    end
  end
end
