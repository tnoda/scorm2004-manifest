module Scorm2004
  module Manifest
    class NavigationInterface
      include VisitorPattern
      include Children

      # @attribute [r] hide_lmsuis
      # @return [Array<HideLmsui>] <adlnav:hideLMSUI>
      has_zero_or_more 'adlnav:hideLMSUI'
    end
  end
end
