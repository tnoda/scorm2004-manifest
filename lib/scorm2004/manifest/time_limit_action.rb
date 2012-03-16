module Scorm2004
  module Manifest
    class TimeLimitAction
      include VisitorPattern
      include TextNode
      
      def self.vocabulary
        [ 'exit, message',
          'exit,no message',
          'continue, message',
          'continue,no message' ]
      end

      private
      
      def do_visit
        unless self.class.vocabulary.include?(content)
          error("Invalid <adlcp:timeLimitAction> token: #{content}") 
        end
      end
    end
  end
end
