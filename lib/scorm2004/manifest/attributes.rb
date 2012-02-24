module Scorm2004
  module Manifest
    module Attributes
      def self.included(base)
        base.extend(ClassMethods)
      end

      def xs_id?(str)
        (/\s|^\d+$/ =~ str).nil?
      end
      
      module ClassMethods
        def attributes
          @attributes ||= []
        end

        def attribute(type, name, options = {})
          base = basename(name)
          attributes << base
          define_method("raw_#{base}") do
            el.at("./@#{name}").try(:content) || options[:default].try(:to_s)
          end
          send("#{type}_attribute", name, options)
          attr_reader base
        end

        def boolean_attribute(name, options)
          base = basename(name)
          define_method("check_#{base}".intern) do
            raw = send("raw_#{base}")
            error("No #{name} attribute.") if raw.nil?
            unless %( true false 1 0 ).include?(raw)
              error("Non xs:boolean value for the #{name}: #{raw}")
            end
            instance_variable_set("@#{base}".intern, %( true 1 ).include?(raw))
          end
        end

        def string_attribute(name, options)
          base = basename(name)
          define_method("check_#{base}".intern) do
            raw = send("raw_#{base}")
            error("No #{name} attribute.") if raw.nil?
            if options[:spm] && raw.length > options[:spm]
              error("The length of #{name} exceeds the SPM of #{options[:spm]} characters.")
            end
            instance_variable_set("@#{base}".intern, raw)
          end
        end

        def id_attribute(name, options)
          base = basename(name)
          define_method("check_#{base}".intern) do
            raw = send("raw_#{base}")
            error("No #{name} attribute.") if raw.nil?
            error("Non xs:ID value for the #{name} attribute: #{raw}") unless xs_id?(raw)
            instance_variable_set("@#{base}".intern, raw)
          end
        end

        def decimal_attribute(name, options)
          base = basename(name)
          define_method("check_#{base}".intern) do
            raw = send("raw_#{base}".intern)
            error("No #{name} attribute.") if raw.nil?
            if options[:range] && !options[:range].include?(Float(raw))
              error("The decimal attribute, #{name}, out of range (#{options[:range]}): #{raw}")
            end
            instance_variable_set("@#{base}".intern, Float(raw))
          end
        end

        private

        def basename(name)
          name.split(':').last.underscore.intern
        end
      end
    end
  end
end