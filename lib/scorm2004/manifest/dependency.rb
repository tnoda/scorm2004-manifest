module Scorm2004
  module Manifest
    class Dependency
      include VisitorPattern
      include Attributes
      
      # @attribute [r] identifierref
      # @return [String] The identifierref attribute of <dependency>
      attribute :string, 'identifierref'

      private
      
      def do_visit
        error('Referenced <resource> not found:') unless referenced_resource
      end

      def referenced_resource
        @el.at("/imscp:manifest/imscp:resources/imscp:resource[@identifier='#{identifierref}']", NS)
      end
    end
  end
end
