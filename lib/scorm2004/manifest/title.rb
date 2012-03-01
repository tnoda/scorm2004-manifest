module Scorm2004
  module Manifest
    class Title
      include VisitorPattern
      include CustomError
      
      def content
        el.content
      end
      alias :to_s :content

      private
      
      def do_visit
        error('Empty <title> element.') unless content.present?
        error('The <title> element exceeds the SPM of 200 characters: ' + el.to_s) if content.length > 200
      end
    end
  end
end
