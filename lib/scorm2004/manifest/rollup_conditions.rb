module Scorm2004
  module Manifest
    class RollupConditions
      include VisitorPattern
      include Children
      include Attributes

      # @attribute [r] condition_combination
      # @return [String] The +conditionCombination+ attribute of <rollupConditions>
      attribute :token, 'conditionCombination', vocabulary: %w( any all ), default: 'any'

      # @attribute [r] rollup_conditions
      # @return [Array<RollupCondition>] <imsss:rollupCondition>
      has_one_or_more 'imsss:rollupCondition'
    end
  end
end
