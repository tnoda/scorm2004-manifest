module Scorm2004
  module Manifest
    class RollupConsiderations
      include VisitorPattern
      include CustomError
      include Attributes
      
      CONDITIONS = %w( always ifAttempted ifNotSkipped ifNotSuspended )

      %w( requiredForSatisfied requireForNotSatisfied requiredForCompleted requireForIncomplete ).each do |attr|
        attribute :token, attr, vocabulary: CONDITIONS, default: CONDITIONS.first
      end
      
      attribute :boolean, 'measureSatisfactionIfActive', default: true
    end
  end
end
