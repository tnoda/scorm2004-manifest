module Scorm2004
  module Manifest
    class PrimaryObjective
      include VisitorPattern
      include Children
      include Attributes
      
      attribute :boolean, 'satisfiedByMeasure', default: false
      attribute :any_uri, 'objectiveID', allow_nil: true

      # @attribute [r] min_normalized_measure
      # @return [MinNormalizedMeasure, nil] <imsss:minNormalizedMeasure>
      has_zero_or_one 'imsss:minNormalizedMeasure'

      # @attribute [r] map_infos
      # @return [Array<MapInfo>] <imsss:mapInfo>
      has_zero_or_more 'imsss:mapInfo'

      private
      
      def do_visit
        error(<<EOS) if el.at('./imsss:mapInfo', NS) && objective_id.nil?
If a <primaryObjective> contains an objective map (<mapInfo>), then the objectiveID attribute is required.
EOS
      end
    end
  end
end
