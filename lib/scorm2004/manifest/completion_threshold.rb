module Scorm2004
  module Manifest
    class CompletionThreshold
      include VisitorPattern
      include Attributes
      
      # @attribute [r] completed_by_measure
      # @return [Boolean] The +completedByMeasure+ attribute of <completionThreshold>
      attribute :boolean, 'completedByMeasure', default: false

      # @attribute [r] min_progress_measure
      # @return [Float] The +minProgressMeasure+ attribute of <completionThreshold>
      attribute :decimal, 'minProgressMeasure', default: 1.0, range: 0.0..1.0

      # @attribute [r] progress_weight
      # @return [Float] The +progressWeight+ attribute of <completionThreshold>
      attribute :decimal, 'progressWeight',     default: 1.0, range: 0.0..1.0
    end
  end
end
