module Scorm2004
  module Manifest
    class RuleConditions
      include VisitorPattern
      include Children
      include Attributes

      attribute :token, 'conditionCombination', vocabulary: %w( all any ), default: 'all'

      has_one_or_more 'imsss:ruleCondition'
    end
  end
end
