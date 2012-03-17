module Scorm2004
  module Manifest
    class RandomizationControls
      include VisitorPattern
      include Attributes

      TIMINGS = %w( never once onEachNewAttempt )

      # @attribute [r] randomization_timing
      # @return [String] The +randomizationTiming+ attribute of <randomizationControls>
      attribute :token, 'randomizationTiming', vocabulary: TIMINGS, default: 'never'

      # @attribute [r] select_count
      # @return [Fixnum] The +selectCount+ attribute of <randomizationControls>
      attribute :non_negative_integer, 'selectCount', allow_nil: true

      # @attribute [r] reorder_children
      # @return [Boolean] The +reorderChildren+ attribute of <randomizationControls>
      attribute :boolean, 'reorderChildren', default: false

      # @attribute [r] selection_timing
      # @return [String] The +selectionTiming+ attribute of <randomizationControls>
      attribute :token, 'selectionTiming', vocabulary: TIMINGS, default: 'never'
    end
  end
end
