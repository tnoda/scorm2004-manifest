module Scorm2004
  module Manifest
    class Objectives
      include VisitorPattern
      include CustomError
      include Children

      has_one_and_only_one 'imsss:primaryObjective'
      has_zero_or_more 'imsss:objective'
    end
  end
end
