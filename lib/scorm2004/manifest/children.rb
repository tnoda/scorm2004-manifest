module Scorm2004
  module Manifest
    module Children
      def self.included(base)
        base.extend(ClassMethods)
      end
      
      private

      def at(xpath)
        xpath = './' + xpath unless /^\.\// =~ xpath
        el.at(xpath, NS)
      end

      def search(xpath)
        xpath = './' + xpath unless /^\.\// =~ xpath
        el.search(xpath, NS)
      end

      def create_visitor(name)
        send("#{name}_visitor".intern)
      end

      module ClassMethods
        def children
          @children ||= []
        end

        def has_one(xpath, options = {})
          name = guess_child_name(xpath, options)
          children << name.intern
          attr_reader name.intern
          define_method("visit_#{name}".intern) do
            error("Two <#{xpath}> elements found.") if search(xpath).size > 1
            error("<#{xpath}> not found.") unless options[:allow_nil] || at(xpath)
            if at(xpath)
              instance_variable_set("@#{name}".intern, at(xpath).accept(create_visitor(name)))
            end
          end
          define_visitor(name)
        end
        alias :has_one_and_only_one :has_one

        def has_zero_or_one(xpath, options = {})
          has_one(xpath, options.merge( { :allow_nil => true } ))
        end

        def has_many(xpath, options = {})
          name = guess_child_name(xpath, options).singularize
          children << name.pluralize.intern
          attr_reader name.pluralize.intern
          define_method("visit_#{name.pluralize}".intern) do
            unless options[:allow_nil] || search(xpath).size > 0
              error("<#{xpath}> not found.")
            end
            instance_variable_set("@#{name.pluralize}".intern, search(xpath).map { |child|
                child.accept(create_visitor(name))
              } )
          end
          define_visitor(name)
        end
        alias :has_one_or_more :has_many

        def has_zero_or_more(xpath, options = {})
          has_many(xpath, options.merge( { :allow_nil => true} ))
        end

        def guess_child_name(xpath, options)
          options[:visitor].try(:to_s) || xpath.split(%r{[/:]}).last.underscore
        end

        def define_visitor(name)
          define_method("#{name}_visitor".intern) do
            options = respond_to?(:base) ? { :base => base } : {}
            "Scorm2004::Manifest::#{name.camelize}".constantize.new(options)
          end
        end
      end
    end
  end
end
