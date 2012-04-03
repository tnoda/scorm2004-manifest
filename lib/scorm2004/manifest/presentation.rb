module Scorm2004
  module Manifest
    class Presentation
      include VisitorPattern
      include Children
      
      # @attribute [r] navigation_interface
      # @return [NavigationInterface, nil] <adlnav:navigationInterface>
      has_zero_or_one 'adlnav:navigationInterface'
    end
  end
end
