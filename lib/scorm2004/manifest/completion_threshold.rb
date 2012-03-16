module Scorm2004
  module Manifest
    class CompletionThreshold
      include VisitorPattern
      include Attributes
      
      attribute :boolean, 'completedByMeasure', default: false
      attribute :decimal, 'minProgressMeasure', default: 1.0, range: 0.0..1.0
      attribute :decimal, 'progressWeight',     default: 1.0, range: 0.0..1.0
    end
  end
end
