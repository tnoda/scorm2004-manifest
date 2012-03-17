module Scorm2004
  module Manifest
    class Resource
      include VisitorPattern
      include Children
      include Attributes
      include XmlBase
      include Href
      
      # @attribute [r] identifier
      # @return [String] The identifier attribute of <resource>
      attribute :id, 'identifier'

      # @attribute [r] scorm_type
      # @return [String] The adlcp:scormType attribute of <resource>, +sco+ or +asset+
      attribute :token, 'adlcp:scormType', vocabulary: %w( sco asset )

      # @attribute [r] files
      # @return [Array<File>] <file>
      has_zero_or_more 'imscp:file'

      # @attribute [r] dependencies
      # @return [Array<Dependency>] <dependency>
      has_zero_or_more 'imscp:dependency'
    end
  end
end
