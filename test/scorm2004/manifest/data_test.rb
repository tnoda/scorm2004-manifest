require_relative '../../helper'

module Scorm2004
  module Manifest
    class DataTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Scorm2004::Manifest::Data.new
      end
      
      test 'an empty element' do
        assert_raise Data::Error do
          el('<dummy />').accept(@v)
        end
      end

      test 'an element with children' do
        map_visitor = mock()
        map_visitor.expects(:visit).twice
        @v.expects(:map_visitor).twice.returns(map_visitor)
        assert el(<<-XML).accept(@v)
          <dummy>
            <adlcp:map />
            <adlcp:map />
          </dummy>
        XML
      end
    end
  end
end
