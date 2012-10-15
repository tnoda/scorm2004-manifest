module Scorm2004
  module Manifest
    class Organizations
      include VisitorPattern
      include Children
      include Attributes
      include XmlBase
      
      # @attribute [r] default
      # @return [String] The default attribute of <organizations>
      attribute :idref, 'default'

      # @attribute [r] organizations
      # @return [Array<Organization>] <organization>
      has_one_or_more 'imscp:organization'

      private
      
      def post_visit
        error('Default <organization> not found: ' + default) unless default_organization
      end

      def default_organization
        organizations.find { |org| org.identifier == default }
      end
    end
  end
end
