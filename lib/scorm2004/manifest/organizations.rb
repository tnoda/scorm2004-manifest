module Scorm2004
  module Manifest
    class Organizations
      include VisitorPattern
      include Children
      include Attributes
      include XmlBase
      
      attribute :idref, 'default'
      has_one_or_more 'imscp:organization'

      private
      
      def do_visit
        error('Default <resource> not found: ' + default) unless default_resource
      end

      def default_resource
        el.at("/imscp:manifest/imscp:organizations/imscp:organization[@identifier='#{default}']", NS)
      end
    end
  end
end
