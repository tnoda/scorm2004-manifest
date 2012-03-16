module Scorm2004
  module Manifest
    class MapInfo
      include VisitorPattern
      include Attributes
      
      attribute :any_uri, 'targetObjectiveID'
      attribute :boolean, 'readSatisfiedStatus', default: true
      attribute :boolean, 'readNormalizedMeasure', default: true
      attribute :boolean, 'writeSatisfiedStatus', default: false
      attribute :boolean, 'writeNormalizedMeasure', default: false
    end
  end
end
