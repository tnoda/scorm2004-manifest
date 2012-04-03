module Scorm2004
  module Manifest
    class LimitConditions
      include VisitorPattern
      include Attributes
      
      # @attribute [r] attempt_limit
      # @return [Fixnum] The +attemptLimit+ attribute of <limitConditions>
      attribute :non_negative_integer, 'attemptLimit',                 allow_nil: true

      # @attribute [r] attempt_absolute_duration_limit
      # @return [String] The +attemptAbsoluteDurationLimit+ attribute of <limitConditions>
      attribute :duration,             'attemptAbsoluteDurationLimit', allow_nil: true
    end
  end
end
