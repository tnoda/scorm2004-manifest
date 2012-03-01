module Scorm2004
  module Manifest
    class Dependency
      include VisitorPattern
      include CustomError
      include Attributes
      
      attribute :string, 'identifierref'

      private
      
      def do_visit
        error('Referenced <resource> not found: ' + el.to_s) unless referenced_resource
      end

      def referenced_resource
        el.at("/imscp:manifest/imscp:resources/imscp:resource[@identifier='#{identifierref}']", NS)
      end
    end
  end
end
