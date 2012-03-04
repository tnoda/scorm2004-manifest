module Scorm2004
  module Manifest
    class SequencingCollection
      include VisitorPattern
      include CustomError
      include Children

      has_one_or_more 'imsss:sequencing'
    end
  end
end
