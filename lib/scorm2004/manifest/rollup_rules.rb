module Scorm2004
  module Manifest
    class RollupRules
      include VisitorPattern
      include Children
      include Attributes

      # @attribute [r] rollup_objective_satisfied
      # @return [Boolean] The +rollupObjectiveSatisfied+ attribute of <rollupRules>
      attribute :boolean, 'rollupObjectiveSatisfied', default: true

      # @attribute [r] rollup_progress_completion
      # @return [Boolean] The +rollupProgressCompletion+ attribute of <rollupRules>
      attribute :boolean, 'rollupProgressCompletion', default: true

      # @attribute [r] objective_measure_weight
      # @return [Float] The +objectiveMeasureWeight+ attribute of <rollupRules>
      attribute :decimal, 'objectiveMeasureWeight', range: 0.0..1.0, default: 1.0

      # @attribute [r] rollup_rules
      # @return [Array<RollupRule>] <imsss:rollupRule>
      has_zero_or_more 'imsss:rollupRule'
    end
  end
end
