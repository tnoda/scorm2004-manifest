module Scorm2004
  module Manifest
    module VisitorPattern
      def self.included(base)
        base.class_eval do
          const_set('Error', Class.new(Scorm2004::Manifest::Error))
        end
      end

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

      # @return [Nokogiri::XML::Node, nil] The <metadata> element or +nil+
      def metadata
        @el.at('./imscp:metadata', NS)
      end

      private

      def error(message)
        raise("#{self.class}::Error".constantize, [message, @el.try(:to_s)].compact.join("\n"))
      end

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
