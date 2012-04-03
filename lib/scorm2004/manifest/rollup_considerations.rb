module Scorm2004
  module Manifest
    class RollupConsiderations
      include VisitorPattern
      include Attributes
      
      CONDITIONS = %w( always ifAttempted ifNotSkipped ifNotSuspended )
      ATTRIBUTES = [
        'requiredForSatisfied',
        'requireForNotSatisfied',
        'requiredForCompleted',
        'requireForIncomplete'
      ]

      ATTRIBUTES.each do |attr|
        attribute :token, attr, vocabulary: CONDITIONS, default: CONDITIONS.first
      end
      
      # @attribute [r] measure_satisfaction_if_active
      # @return [Boolean] The +measureSatisfactionIfActive+ attribute of <rollupConsideration>
      attribute :boolean, 'measureSatisfactionIfActive', default: true
    end
  end
end
