module Scorm2004
  module Manifest
    class SequencingCollection
      include VisitorPattern
      include Children

      # @attribute sequencings
      # @return [Array<Sequencing>] <imsss:sequencing>
      has_one_or_more 'imsss:sequencing'
    end
  end
end
