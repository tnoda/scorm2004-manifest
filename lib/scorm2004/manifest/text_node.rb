module Scorm2004
  module Manifest
    module TextNode
      def content
        @el.content
      end
      alias :to_s :content
      alias :to_str :content
    end
  end
end
