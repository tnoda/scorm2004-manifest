module Scorm2004
  module Manifest
    class Data
      include VisitorPattern
      include CustomError
      include Children

      has_one_or_more 'adlcp:map'
    end
  end
end
