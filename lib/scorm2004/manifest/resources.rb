module Scorm2004
  module Manifest
    class Resources
      include VisitorPattern
      include Children
      include XmlBase
      
      # @attribute [r] resources
      # @return [Array<Resource>] <resource>
      has_zero_or_more 'imscp:resource'
    end
  end
end
