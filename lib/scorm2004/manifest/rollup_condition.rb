module Scorm2004
  module Manifest
    class RollupCondition
      include VisitorPattern
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

      # @attribute [r] operator
      # @return [String] The +operator+ attribute of <rollupCondition>
      attribute :token, 'operator', vocabulary: %w( not noOp ), default: 'noOp'

      # @attribute [r] condition
      # @return [String] The +condition+ attribute of <rollupCondition>
      attribute :token, 'condition', vocabulary: CONDITIONS
    end
  end
end
