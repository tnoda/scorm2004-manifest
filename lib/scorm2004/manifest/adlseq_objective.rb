module Scorm2004
  module Manifest
    class AdlseqObjective
      include VisitorPattern
      include Children
      include Attributes

      # @attribute [r] objective_id
      # @return [String] The +objectiveID+ attribute of <adlseq:Objective>
      attribute :any_uri, 'objectiveID'

      # @attribute [r] adlseq_map_infos
      # @return [Array<AdlseqMapInfo>] <adlseq:mapInfo>
      has_one_or_more 'adlseq:mapInfo', visitor: :adlseq_map_info
    end
  end
end
