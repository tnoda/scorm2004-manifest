module Scorm2004
  module Manifest
    class Map
      include VisitorPattern
      include Attributes
      
      # @attribute [r] target_id
      # @return [String] The +targetID+ attribute of <map>
      attribute :any_uri, 'targetID'

      # @attribute [r] read_shared_data
      # @return [Boolean] The +readSharedData+ attribute of <map>
      attribute :boolean, 'readSharedData',  default: true

      # @attribute [r] write_shared_data
      # @return [Boolean] The +writeSharedData+ attribute of <map>
      attribute :boolean, 'writeSharedData', default: true
    end
  end
end
