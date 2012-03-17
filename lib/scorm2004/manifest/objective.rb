module Scorm2004
  module Manifest
    class Objective
      include VisitorPattern
      include Children
      include Attributes

      # @attribute [r] satisfied_by_measure
      # @return [Boolean] The +satisfiedByMeasure+ attribute of <objective>
      attribute :boolean, 'satisfiedByMeasure', default: false

      # @attribute [r] objective_id
      # @return [String] The +objectiveID+ attribute of <objective>
      attribute :any_uri, 'objectiveID'

      # @attribute [r] min_normalized_measure
      # @return [MinNormalizedMeasure, nil] <imsss:minNormalizedMeasure>
      has_zero_or_one 'imsss:minNormalizedMeasure'

      # @attribute [r] map_infos
      # @return [Array<MapInfo>] <imsss:mapInfo>
      has_zero_or_more 'imsss:mapInfo'
    end
  end
end
