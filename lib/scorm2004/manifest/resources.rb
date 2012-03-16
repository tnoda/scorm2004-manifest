module Scorm2004
  module Manifest
    class Resources
      include VisitorPattern
      include Children
      include XmlBase
      
      has_zero_or_more 'imscp:resource'
    end
  end
end
