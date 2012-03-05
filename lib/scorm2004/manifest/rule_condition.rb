module Scorm2004
  module Manifest
    class RuleCondition
      include VisitorPattern
      include CustomError
      include Attributes
      
      CONDITIONS = %w( objectiveMeasureKnown objectiveMeasureGreaterThan objectiveMeasureLessThan completed activityProgressKnown attempted attemptLimitExceeded timeLimitExceeded outsideAvailableTimeRange always )

      attribute :token,   'operator',            vocabulary: %w( not noOp ), default: 'noOp'
      attribute :string,  'referencedObjective', allow_nil: true
      attribute :decimal, 'measureThreshold',    range: -1.0..1.0, allow_nil: true
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
