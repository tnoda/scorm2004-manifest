module Scorm2004
  module Manifest
    class AdlseqObjective
      include VisitorPattern
      include CustomError
      include Children
      include Attributes

      attribute :any_uri, 'objectiveID'

      has_one_or_more 'adlseq:mapInfo', visitor: :adlseq_map_info
    end
  end
end
