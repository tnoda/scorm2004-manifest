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
        do_visit         if self.respond_to?(:do_visit, true)
        visit_children   if self.class.respond_to?(:children)
        self
      end

      private

      def check_attributes
        self.class.attributes.each do |attr|
          send("check_#{attr}".intern)
        end
      end

      def visit_children
        self.class.children.each do |child|
          send("visit_#{child}".intern)
        end
      end
    end
  end
end
