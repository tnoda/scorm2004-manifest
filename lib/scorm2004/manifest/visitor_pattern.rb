module Scorm2004
  module Manifest
    module VisitorPattern
      attr_reader :el

      def initialize(options = {})
        @options = options
      end

      def visit(el)
        @el = el
        check_attributes if self.class.respond_to?(:attributes)
        do_visit         if self.respond_to?(:do_visit)
        self
      end

      def check_attributes
        self.class.attributes.each do |attr|
          send("check_#{attr}".intern)
        end
      end
    end
  end
end
