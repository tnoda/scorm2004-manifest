module Scorm2004
  module Manifest
    class HideLmsui
      include VisitorPattern
      include TextNode
      
      VOCABULARY = %w( previous continue exit exitAll abandon abandonAll suspendAll )

      private
      
      def do_visit
        unless VOCABULARY.include?(content)
          error("Invalid <adlnav:hideLMSUI> token: #{content}")
        end
      end
    end
  end
end
