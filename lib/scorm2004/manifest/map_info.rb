module Scorm2004
  module Manifest
    class MapInfo
      include VisitorPattern
      include Attributes
      
      # @attribute [r] target_objective_id
      # @return [String] The +targetObjectiveID+ attribute of <mapinfo>
      attribute :any_uri, 'targetObjectiveID'

      # @attribute [r] read_satisfied_status
      # @return [Boolean] The +readSatisfiedStatus+ attribute of <mapInfo>
      attribute :boolean, 'readSatisfiedStatus', default: true

      # @attribute [r] read_normalized_measure
      # @return [Boolean] The +readNormalizedMeasure+ attribute of <mapInfo>
      attribute :boolean, 'readNormalizedMeasure', default: true

      # @attribute [r] write_satisfied_status
      # @return [Boolean] The +writeSatisfiedStatus+ attribute of <mapInfo>
      attribute :boolean, 'writeSatisfiedStatus', default: false

      # @attribute [r] write_normalized_measure
      # @return [Boolean] The +writeNormalizedMeasure+ attribute of <mapInfo>
      attribute :boolean, 'writeNormalizedMeasure', default: false
    end
  end
end
