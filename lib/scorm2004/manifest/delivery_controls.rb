module Scorm2004
  module Manifest
    class DeliveryControls
      include VisitorPattern
      include Attributes
      
      attribute :boolean, 'tracked',                default: true
      attribute :boolean, 'completionSetByContent', default: false
      attribute :boolean, 'objectiveSetByContent',  default: false
    end
  end
end
