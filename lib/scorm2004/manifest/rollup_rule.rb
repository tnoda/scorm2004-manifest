module Scorm2004
  module Manifest
    class RollupRule
      include VisitorPattern
      include CustomError
      include Children
      include Attributes

      CONDITIONS = %w( all any none atLeastCount atLeastPercent )

      attribute :token, 'childActivitySet', vocabulary: CONDITIONS, default: CONDITIONS.first
      attribute :non_negative_integer, 'minimumCount', default: 0
      attribute :decimal, 'minimumPercent', range: 0.0..1.0, default: 0.0

      has_one_and_only_one 'imsss:rollupConditions'
      has_one_and_only_one 'imsss:rollupAction'
    end
  end
end
