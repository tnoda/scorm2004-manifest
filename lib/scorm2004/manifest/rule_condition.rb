module Scorm2004
  module Manifest
    class RuleCondition
      include VisitorPattern
      include CustomError
      include Attributes
      
      VOCABULARY = %w( objectiveMeasureKnown objectiveMeasureGreaterThan objectiveMeasureLessThan completed activityProgressKnown attempted attemptLimitExceeded timeLimitExceeded outsideAvailableTimeRange always )

      attribute :token,   'operator',            vocabulary: %w( not noOp ), default: 'noOp'
      attribute :string,  'referencedObjective', allow_nil: true
      attribute :decimal, 'measureThreshold',   range: -1.0..1.0, allow_nil: true
      attribute :token,   'condition',           vocabulary: VOCABULARY
    end
  end
end
