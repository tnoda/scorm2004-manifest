module Scorm2004
  module Manifest
    class HideLmsui
      include VisitorPattern
      include CustomError
      include TextNode
      
      def self.vocabulary
        %w( previous continue exit exitAll abandon abandonAll suspendAll )
      end

      private
      
      def do_visit
        unless self.class.vocabulary.include?(content)
          error("Invalid <adlnav:hideLMSUI> token: #{content}")
        end
      end
    end
  end
end
