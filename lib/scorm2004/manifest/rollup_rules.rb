module Scorm2004
  module Manifest
    class RollupRules
      include VisitorPattern
      include CustomError
      include Children
      include Attributes

      attribute :boolean, 'rollupObjectiveSatisfied', default: true
      attribute :boolean, 'rollupProgressCompletion', default: true
      attribute :decimal, 'objectiveMeasureWeight', range: 0.0..1.0, default: 1.0

      has_zero_or_more 'imsss:rollupRule'
      has_one_and_only_one 'imsss:rollupConditions'
      has_one_and_only_one 'imsss:rollupAction'
    end
  end
end
