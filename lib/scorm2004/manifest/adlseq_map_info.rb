module Scorm2004
  module Manifest
    class AdlseqMapInfo
      include VisitorPattern
      include Attributes

      # @attribute [r] target_objective_id
      # @return [String] The +targetObjectiveID+ attribute of <adlseq:mapInfo>
      attribute :any_uri, 'targetObjectiveID'

      elements = %w( RawScore MinScore MaxScore CompletionStatus ProgressMeasure )
      %w( read write ).product(elements).map(&:join).each do |attr|
        default_value = /^read/ =~ attr ? true : false
        attribute :boolean, attr, default: default_value
      end
    end
  end
end
