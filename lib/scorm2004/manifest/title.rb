module Scorm2004
  module Manifest
    class Title
      include VisitorPattern
      include CustomError
      include TextNode

      private
      
      def do_visit
        error('Empty <title> element.') unless content.present?
        error('The <title> element exceeds the SPM of 200 characters:') if content.length > 200
      end
    end
  end
end
