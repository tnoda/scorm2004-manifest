module Scorm2004
  module Manifest
    class File
      include VisitorPattern
      include XmlBase
      include Href
      
      private
      
      def do_visit
        error('href attribute not found:') unless href
      end
    end
  end
end
