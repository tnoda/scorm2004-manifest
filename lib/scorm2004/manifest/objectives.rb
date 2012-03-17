module Scorm2004
  module Manifest
    class Objectives
      include VisitorPattern
      include Children

      # @attribute [r] primary_objective
      # @return [PrimaryObjective] <imsss:primaryObjective>
      has_one_and_only_one 'imsss:primaryObjective'

      # @attribute [r] objectives
      # @return [Array<Objective>] <imsss:objective>
      has_zero_or_more 'imsss:objective'
    end
  end
end
