module Scorm2004
  module Manifest
    class DataFromLms
      include VisitorPattern
      include TextNode

      SPM = 4000

      private
      
      def do_visit
        if content.length > SPM
          error("<adlcp:dataFromLMS> exceeds the SPM of #{SPM}: #{content}")
        end
      end
    end
  end
end
