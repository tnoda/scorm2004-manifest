require_relative '../../helper'

module Scorm2004
  module Manifest
    class NavigationInterfaceTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = NavigationInterface.new
      end
      
      test 'an empty element' do
        assert el('<dummy />').accept(@v)
      end

      test 'an element with children' do
        hide_lmsui_visitor = mock()
        hide_lmsui_visitor.expects(:visit).twice
        @v.expects(:hide_lmsui_visitor).twice.returns(hide_lmsui_visitor)
        assert el(<<-XML).accept(@v)
          <dummy>
            <adlnav:hideLMSUI />
            <adlnav:hideLMSUI />
          </dummy>
        XML
      end
    end
  end
end
