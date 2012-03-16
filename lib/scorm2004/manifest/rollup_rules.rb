module Scorm2004
  module Manifest
    class RollupRules
      include VisitorPattern
      include Children
      include Attributes

      attribute :boolean, 'rollupObjectiveSatisfied', default: true
      attribute :boolean, 'rollupProgressCompletion', default: true
      attribute :decimal, 'objectiveMeasureWeight', range: 0.0..1.0, default: 1.0

      has_zero_or_more 'imsss:rollupRule'
    end
  end
end
