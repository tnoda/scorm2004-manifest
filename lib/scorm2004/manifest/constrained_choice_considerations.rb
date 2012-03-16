module Scorm2004
  module Manifest
    class ConstrainedChoiceConsiderations
      include VisitorPattern
      include Attributes

      attribute :boolean, 'preventActivation', default: false
      attribute :boolean, 'constrainChoice',   default: false
    end
  end
end
