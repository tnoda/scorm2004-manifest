module Scorm2004
  module Manifest
    class Sequencing
      include VisitorPattern
      include Children
      include Attributes
      
      # @attribute [r] id
      # @return [String] The +ID+ attribute of <sequencing>
      attribute :id,    'ID',    allow_nil: true

      # @attribute [r] idref
      # @return [String] The +IDRef+ attribute of <sequencing>
      attribute :idref, 'IDRef', allow_nil: true

      # @attribute [r] control_mode
      # @return [ControlMode, nil] <imsss:controlMode>
      has_zero_or_one 'imsss:controlMode'

      # @attribute [r] sequencing_rules
      # @return [SequencingRules, nil] <imsss:sequencingRules>
      has_zero_or_one 'imsss:sequencingRules'

      # @attribute [r] limit_conditions
      # @return [LimitConditions, nil] <imsss:limitConditions>
      has_zero_or_one 'imsss:limitConditions'

      # @attribute [r] rollup_rules
      # @return [RollupRules, nil] <imsss:rollupRules>
      has_zero_or_one 'imsss:rollupRules'

      # @attribute [r] objectives
      # @return [Objectives, nil] <imsss:objectives>
      has_zero_or_one 'imsss:objectives'

      # @attribute [r] randomization_controls
      # @return [RandomizationControls, nil] <imsss:randomizationControls>
      has_zero_or_one 'imsss:randomizationControls'

      # @attribute [r] delivery_controls
      # @return [DeliveryControls, nil] <imsss:deliveryControls>
      has_zero_or_one 'imsss:deliveryControls'

      # @attribute [r] constrained_choice_considerations
      # @return [ConstrainedChoiceConsiderations, nil] <imsss:constrainedChoiceConsiderations>
      has_zero_or_one 'adlseq:constrainedChoiceConsiderations'

      # @attribute [r] rollup_considerations
      # @return [RollupConsiderations, nil] <adlseq:rollupConsiderations>
      has_zero_or_one 'adlseq:rollupConsiderations'

      # @attribute [r] adlseq_objectives
      # @return [AdlseqObjectives, nil] <adlseq:objectives>
      has_zero_or_one 'adlseq:objectives', name: 'adlseq_objectives', visitor: :adlseq_objectives
    end
  end
end
