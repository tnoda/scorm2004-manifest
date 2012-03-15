module Scorm2004
  module Manifest
    class LimitConditions
      include VisitorPattern
      include CustomError
      include Attributes
      
      attribute :non_negative_integer, 'attemptLimit',                 allow_nil: true
      attribute :duration,             'attemptAbsoluteDurationLimit', allow_nil: true
    end
  end
end
