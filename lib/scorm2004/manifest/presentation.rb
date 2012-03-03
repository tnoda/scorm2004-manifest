module Scorm2004
  module Manifest
    class Presentation
      include VisitorPattern
      include Children
      
      has_zero_or_one 'adlnav:navigationInterface'
    end
  end
end
