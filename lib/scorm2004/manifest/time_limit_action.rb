module Scorm2004
  module Manifest
    class TimeLimitAction
      include VisitorPattern
      include TextNode
      
      VOCABULARY = [
        'exit, message',
        'exit,no message',
        'continue, message',
        'continue,no message'
      ]

      private
      
      def do_visit
        unless VOCABULARY.include?(content)
          error("Invalid <adlcp:timeLimitAction> token: #{content}") 
        end
      end
    end
  end
end
