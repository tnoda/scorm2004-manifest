require_relative '../../helper'

module Scorm2004
  module Manifest
    class PresentationTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Presentation.new
      end
      
      test 'an empty element' do
        assert el('<dummy />').accept(@v)
      end

      test 'an element with child' do
        @v.expects(:navigation_interface_visitor).once.returns(mock(:visit))
        assert el(<<-XML).accept(@v)
          <dummy>
            <adlnav:navigationInterface />
          </dummy>
        XML
      end
    end
  end
end
