module Scorm2004
  module Manifest
    class AdlseqObjectives
      include VisitorPattern
      include Children

      # @attribute [r] adlseq_objectives
      # @return [Array<AdlseqObjective>] <adlseq:objective>
      has_one_or_more 'adlseq:objective', visitor: :adlseq_objective
    end
  end
end
