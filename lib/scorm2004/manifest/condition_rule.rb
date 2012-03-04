module Scorm2004
  module Manifest
    class ConditionRule
      include VisitorPattern
      include CustomError
      include Children

      has_one_and_only_one 'imsss:ruleConditions'
      has_one_and_only_one 'imsss:ruleAction'
    end
  end
end
