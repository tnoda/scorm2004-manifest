module Scorm2004
  module Manifest
    class TimeLimitAction
      include VisitorPattern
      include CustomError
      
      def self.vocabulary
        [ 'exit, message',
          'exit,no message',
          'continue, message',
          'continue,no message' ]
      end

      def content
        el.content
      end
      alias :to_s :content

      private
      
      def do_visit
        unless self.class.vocabulary.include?(content)
          error("Invalid <adlcp:timeLimitAction> token: #{content}") 
        end
      end
    end
  end
end
