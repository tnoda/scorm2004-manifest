module Scorm2004
  module Manifest
    class Schemaversion
      include VisitorPattern
      
      private
      
      def do_visit
        error("Invalid schemaversion: #{el.content}") unless valid?
      end

      def valid?
        '2004 4th Edition' == el.content
      end
    end
  end
end
