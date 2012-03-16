module Scorm2004
  module Manifest
    class RandomizationControls
      include VisitorPattern
      include Attributes

      TIMINGS = %w( never once onEachNewAttempt )

      attribute :token, 'randomizationTiming', vocabulary: TIMINGS, default: 'never'
      attribute :non_negative_integer, 'selectCount', allow_nil: true
      attribute :boolean, 'reorderChildren', default: false
      attribute :token, 'selectionTiming', vocabulary: TIMINGS, default: 'never'
    end
  end
end
