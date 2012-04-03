module Scorm2004
  module Manifest
    class ControlMode
      include VisitorPattern
      include Attributes

      # @attribute [r] choice
      # @return [Boolean] The +choice+ attribute of <controlMode>
      attribute :boolean, 'choice',                         default: true

      # @attribute [r] choice_exit
      # @return [Boolean] The +choiceExit+ attribute of <controlMode>
      attribute :boolean, 'choiceExit',                     default: true

      # @attribute [r] flow
      # @return [Boolean] The +flow+ attribute of <controlMode>
      attribute :boolean, 'flow',                           default: false

      # @attribute [r] forward_only
      # @return [Boolean] The +forwardOnly+ attribute of <controlMode>
      attribute :boolean, 'forwardOnly',                    default: false

      # @attribute [r] use_current_attempt_objective_info
      # @return [Boolean] The +useCurrentAttemptObjectiveInfo+ attribute of <controlMode>
      attribute :boolean, 'useCurrentAttemptObjectiveInfo', default: true

      # @attribute [r] use_current_attempt_progress_info
      # @return [Boolean] The +useCurrentAttemptProgressInfo+ attribute of <controlMode>
      attribute :boolean, 'useCurrentAttemptProgressInfo',  default: true
    end
  end
end
