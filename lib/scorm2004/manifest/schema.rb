module Scorm2004
  module Manifest
    class Schema
      include VisitorPattern
      
      private
      
      def do_visit
        error('Invalid schema') unless valid?
      end

      def valid?
        'ADL SCORM' == @el.content
      end
    end
  end
end
