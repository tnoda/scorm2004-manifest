module Scorm2004
  module Manifest
    class RollupConditions
      include VisitorPattern
      include Children
      include Attributes

      attribute :token, 'conditionCombination', vocabulary: %w( any all ), default: 'any'

      has_one_or_more 'imsss:rollupCondition'
    end
  end
end
