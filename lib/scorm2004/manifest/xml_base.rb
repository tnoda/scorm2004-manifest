require 'uri'
require 'pathname'

module Scorm2004
  module Manifest
    module XmlBase
      def base
        normalize_path(parent_base ? resolve_base : relative_base)
      end

      private

      def relative_base
        value = el.at('./@xml:base', NS)
        return unless value
        error("Invalid XML Base value: #{value}") if %r!^/|[^/]$! =~ value
        uri = URI(value)
        uri.absolute? ? uri : Pathname(uri.path)
      end
      
      def parent_base
        @options[:base]
      end

      def resolve_base
        if relative_base.is_a?(URI)
          relative_base
        else
          parent_base + relative_base.to_s
        end
      end

      def normalize_path(path)
        path.is_a?(Pathname) ? (Pathname('/') + path).relative_path_from(Pathname('/')) : path
      end
    end
  end
end
