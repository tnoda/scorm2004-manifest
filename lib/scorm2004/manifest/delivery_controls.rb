module Scorm2004
  module Manifest
    class DeliveryControls
      include VisitorPattern
      include Attributes
      
      # @attribute [r] tracked
      # @return [Boolean] The +tracked+ attribute of <deliveryControls>
      attribute :boolean, 'tracked',                default: true

      # @attribute [r] completion_set_by_content
      # @return [Boolean] The +completion_set_by_content+ attribute of <deliveryControls>
      attribute :boolean, 'completionSetByContent', default: false

      # @attribute [r] objective_set_by_content
      # @return [Boolean] The +objective_set_by_content+ attribute of <deliveryControls>
      attribute :boolean, 'objectiveSetByContent',  default: false
    end
  end
end
