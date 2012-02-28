module Scorm2004
  module Manifest
    module Href
      def href
        base ? resolve_href : relative_href
      end

      private

      def relative_href
        value = el.at('./@href', NS)
        return unless value
        uri = URI(value)
        uri.absolute? ? uri : Pathname(uri.path)
      end

      def resolve_href
        return nil unless relative_href
        return relative_href if relative_href.is_a?(URI)
        base + relative_href.to_s
      end
    end
  end
end
