module Scorm2004
  module Manifest
    module VisitorPattern
      attr_reader :el

      def initialize(options = {})
        @options = options
      end

      def visit(el)
        @el = el
        do_visit if self.respond_to?(:do_visit)
        self
      end
    end
  end
end
