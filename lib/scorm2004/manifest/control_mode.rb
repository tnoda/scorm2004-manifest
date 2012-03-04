module Scorm2004
  module Manifest
    class ControlMode
      include VisitorPattern
      include CustomError
      include Attributes

      attribute :boolean, 'choice',                         default: true
      attribute :boolean, 'choiceExit',                     default: true
      attribute :boolean, 'flow',                           default: false
      attribute :boolean, 'forwardOnly',                    default: false
      attribute :boolean, 'useCurrentAttemptObjectiveInfo', default: true
      attribute :boolean, 'useCurrentAttemptProgressInfo',  default: true
    end
  end
end
