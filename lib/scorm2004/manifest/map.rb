module Scorm2004
  module Manifest
    class Map
      include VisitorPattern
      include CustomError
      include Attributes
      
      attribute :any_uri, 'targetID'
      attribute :boolean, 'readSharedData',  default: true
      attribute :boolean, 'writeSharedData', default: true
    end
  end
end
