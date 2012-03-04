module Scorm2004
  module Manifest
    class SequencingRules
      include VisitorPattern
      include CustomError
      include Children

      has_zero_or_more 'imsss:preConditionRule',  visitor: :condition_rule
      has_zero_or_more 'imsss:postConditionRule', visitor: :condition_rule
      has_zero_or_more 'imsss:exitConditionRule', visitor: :condition_rule
    end
  end
end
