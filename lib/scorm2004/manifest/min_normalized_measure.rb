module Scorm2004
  module Manifest
    class MinNormalizedMeasure
      include VisitorPattern
      
      def to_f
        Float(@el.content)
      end

      private
      
      def do_visit
        error("#{@el} should be between -1 and 1.") unless (-1.0..1.0).include?(to_f)
      end
    end
  end
end
