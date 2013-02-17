module Scorm2004
  module Manifest
    module DecimalNode
      def content
        Float(@el.content)
      end
      alias :to_f :content
    end
  end
end
