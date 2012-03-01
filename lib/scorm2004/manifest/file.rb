module Scorm2004
  module Manifest
    class File
      include VisitorPattern
      include CustomError
      include XmlBase
      include Href
      
      private
      
      def do_visit
        error('href attribute not found: ' + el.to_s) unless href
      end
    end
  end
end
