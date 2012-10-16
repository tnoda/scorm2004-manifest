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
        post_visit       if self.respond_to?(:post_visit, true)
        self
      end

      def to_hash
        if respond_to? :content
          content
        else
          {}.merge(self.class.respond_to?(:attributes) ? attributes_hash : {})
            .merge(self.class.respond_to?(:children) ? children_hash : {})
            .merge(respond_to?(:href) ? {:href => href } : {})
            .reject { |k, v| v.nil? || v == [] || v == {} }
        end
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

      def attributes_hash
        Hash[self.class.attributes.map { |attr| [attr, instance_variable_get("@#{attr}")]}]
      end

      def children_hash
        Hash[self.class.children.map { |child|
            value = instance_variable_get("@#{child}")
            if value.respond_to?(:map)
              [child, value.map { |v| v.to_hash }]
            else
              [child, value.try(:to_hash)]
            end
            }]
      end
    end
  end
end
