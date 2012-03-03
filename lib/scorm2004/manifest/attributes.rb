module Scorm2004
  module Manifest
    module Attributes
      def self.included(base)
        base.extend(ClassMethods)
      end

      private
      
      def replace_and_collapse_whitespaces(string)
        string.gsub(/\s+/, ' ').gsub(/^ | $/, '')
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
            error("No #{name} attribute.") unless options[:allow_nil] || raw
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
        alias :idref_attribute :id_attribute

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

        def token_attribute(name, options)
          base = basename(name)
          define_method("check_#{base}".intern) do
            raw = send("raw_#{base}".intern)
            error("No #{name} attribute.") if raw.nil?
            raw = replace_and_collapse_whitespaces(raw)
            error("Invalid #{name}: #{raw}") unless options[:vocabulary].include?(raw)
            instance_variable_set("@#{base}".intern, raw)
          end
        end

        def any_uri_attribute(name, option)
          base = basename(name)
          define_method("check_#{base}".intern) do
            raw = send("raw_#{base}".intern)
            error("No #{name} attribute.") if raw.nil?
            begin
              uri = URI(raw)
            rescue URI::InvalidURIError => e
              error(e)
            end
            instance_variable_set("@#{base}".intern, uri.to_s)
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
