module Scorm2004
  module Manifest
    class RollupCondition
      include VisitorPattern
      include CustomError
      include Attributes

      CONDITIONS = [
        'satisfied',
        'objectiveStatusKnown',
        'objectiveMeasureKnown',
        'completed',
        'activityProgressKnown',
        'attempted',
        'attemptLimitExceeded',
        'timeLimitExceeded',
        'outsideAvailableTimeRange'
      ]

      attribute :token, 'operator', vocabulary: %w( not noOp ), default: 'noOp'
      attribute :token, 'condition', vocabulary: CONDITIONS
    end
  end
end
