module Scorm2004
  module Manifest
    class Sequencing
      include VisitorPattern
      include Children
      include Attributes
      
      attribute :id,    'ID',    allow_nil: true
      attribute :idref, 'IDRef', allow_nil: true

      has_zero_or_one 'imsss:controlMode'
      has_zero_or_one 'imsss:sequencingRules'
      has_zero_or_one 'imsss:limitConditions'
      has_zero_or_one 'imsss:rollupRules'
      has_zero_or_one 'imsss:objectives'
      has_zero_or_one 'imsss:randomizationControls'
      has_zero_or_one 'imsss:deliveryControls'
      has_zero_or_one 'adlseq:constrainedChoiceConsiderations'
      has_zero_or_one 'adlseq:rollupConsiderations'
      has_zero_or_one 'adlseq:objectives', name: 'adlseq_objectives', visitor: :adlseq_objectives
    end
  end
end
