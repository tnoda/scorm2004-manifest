module Scorm2004
  module Manifest
    class RollupRule
      include VisitorPattern
      include Children
      include Attributes

      CONDITIONS = %w( all any none atLeastCount atLeastPercent )

      # @attribute [r] child_activity_set
      # @return [String] The +childActivitySet+ of <rollupRule>
      attribute :token, 'childActivitySet', vocabulary: CONDITIONS, default: CONDITIONS.first

      # @attribute [r] minimum_count
      # @return [Fixnum] The +minimumCount+ attribute of <rollupRule>
      attribute :non_negative_integer, 'minimumCount', default: 0

      # @attribute [r] minimum_percent
      # @return [Float] The +minimumPercent+ attribute  of <rollupRule>
      attribute :decimal, 'minimumPercent', range: 0.0..1.0, default: 0.0

      # @attribute [r] rollup_conditions
      # @return [RollupConditions] <imsss:rollupConditions>
      has_one_and_only_one 'imsss:rollupConditions'

      # @attribute [r] rollup_action
      # @return [RollupAction] <imsss:rollupAction>
      has_one_and_only_one 'imsss:rollupAction'
    end
  end
end
