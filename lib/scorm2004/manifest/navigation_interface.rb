module Scorm2004
  module Manifest
    class NavigationInterface
      include VisitorPattern
      include Children

      has_zero_or_more 'adlnav:hideLMSUI'
    end
  end
end
