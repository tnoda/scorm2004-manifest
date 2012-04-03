module Scorm2004
  module Manifest
    class Data
      include VisitorPattern
      include Children

      # @attribute [r] maps
      # @return [Array<Map>] <adlcp:map>
      has_one_or_more 'adlcp:map'
    end
  end
end
