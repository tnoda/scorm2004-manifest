module Scorm2004
  module Manifest
    class ConstrainedChoiceConsiderations
      include VisitorPattern
      include Attributes

      # @attribute [r] prevent_activation
      # @return [Boolean] The +preventActivation+ attribute of <constrainedChoiceConsideration>
      attribute :boolean, 'preventActivation', default: false

      # @attribute [r] constrain_choice
      # @return [Boolean] The +constrainChoice+ attribute of <constrainedChoiceConsideration>
      attribute :boolean, 'constrainChoice',   default: false
    end
  end
end
