module Scorm2004
  module Manifest
    class Objective
      include VisitorPattern
      include Children
      include Attributes

      attribute :boolean, 'satisfiedByMeasure', default: false
      attribute :any_uri, 'objectiveID'

      has_zero_or_one 'imsss:minNormalizedMeasure'
      has_zero_or_more 'imsss:mapInfo'
    end
  end
end
