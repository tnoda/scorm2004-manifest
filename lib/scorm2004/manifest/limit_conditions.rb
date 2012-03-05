module Scorm2004
  module Manifest
    class LimitConditions
      include VisitorPattern
      include CustomError
      include Attributes
      
      attribute :non_negative_integer, 'attemptLimit', allow_nil: true

      private
      
      def do_visit
        
      end
    end
  end
end
