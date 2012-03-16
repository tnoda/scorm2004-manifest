module Scorm2004
  module Manifest
    class Resource
      include VisitorPattern
      include Children
      include Attributes
      include XmlBase
      include Href
      
      attribute :id, 'identifier'
      attribute :token, 'adlcp:scormType', vocabulary: %w( sco asset )

      has_zero_or_more 'imscp:file'
      has_zero_or_more 'imscp:dependency'
    end
  end
end
