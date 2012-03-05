module Scorm2004
  module Manifest
    class RollupAction
      include VisitorPattern
      include CustomError
      include Attributes

      VOCABULARY = %w( satisfied notSatisfied completed incomplete )

      attribute :token, 'action', vocabulary: VOCABULARY
    end
  end
end
