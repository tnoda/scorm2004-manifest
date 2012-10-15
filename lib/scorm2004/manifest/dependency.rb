module Scorm2004
  module Manifest
    class Dependency
      include VisitorPattern
      include Attributes
      
      # @attribute [r] identifierref
      # @return [String] The identifierref attribute of <dependency>
      attribute :id, 'identifierref'
    end
  end
end
