module Scorm2004
  module Manifest
    class RollupAction
      include VisitorPattern
      include Attributes

      ACTIONS = %w( satisfied notSatisfied completed incomplete )

      # @attribute [r] action
      # @return [String] The +action+ attribute of <rollupAction>
      attribute :token, 'action', vocabulary: ACTIONS
    end
  end
end
