module Scorm2004
  module Manifest
    class RuleCondition
      include VisitorPattern
      include Attributes
      
      CONDITIONS = [
        'satisfied',
        'objectiveStatusKnown',
        'objectiveMeasureKnown',
        'objectiveMeasureGreaterThan',
        'objectiveMeasureLessThan',
        'completed',
        'activityProgressKnown',
        'attempted',
        'attemptLimitExceeded',
        'timeLimitExceeded',
        'outsideAvailableTimeRange',
        'always'
      ]

      # @attribute [r] operator
      # @return [String] The +operator+ attribute of <ruleCondition>
      attribute :token,   'operator',            vocabulary: %w( not noOp ), default: 'noOp'

      # @attribute [r] referenced_objective
      # @return [String] The +referencedObjective+ attribute of <ruleCondition>
      attribute :string,  'referencedObjective', allow_nil: true

      # @attribute [r] measure_threshold
      # @return [Float] The +measureThreshold+ attribute of <ruleCondition>
      attribute :decimal, 'measureThreshold',    range: -1.0..1.0, allow_nil: true

      # @attribute [r] condition
      # @return [String] The +condition+ attribute of <ruleCondition>
      attribute :token,   'condition',           vocabulary: CONDITIONS

      private

      def do_visit
        return unless referenced_objective
        if '' == referenced_objective
          error('The referencedObjective attribute cannot be an empty string.')
        end
        if /\s/ =~ referenced_objective
          error('The referencedObjective attribute cannot contain any whitespace characters.')
        end
      end
    end
  end
end
