module Scorm2004
  module Manifest
    class DataFromLms
      include VisitorPattern
      include CustomError
      include TextNode

      def self.spm
        4000
      end

      private
      
      def do_visit
        if content.length > self.class.spm
          error("<adlcp:dataFromLMS> exceeds the SPM of #{self.class.spm}: #{content}")
        end
      end
    end
  end
end
