require_relative '../../helper'

module Scorm2004
  module Manifest
    class ObjectiveTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Objective.new
        @v.stubs(:min_normalized_measure_visitor).returns(stub(:visit))
        @v.stubs(:map_info_visitor).returns(stub(:visit))
      end
      
      test 'an empty element cause error' do
        assert_raise(Objective::Error) { el.accept(@v) }
      end

      test 'default satisfiedByMeasure' do
        el('<dummy objectiveID="dummy" />').accept(@v)
        assert_equal false, @v.satisfied_by_measure
      end

      test 'a visitor visits <minNormalizedMeasure>' do
        @v.expects(:min_normalized_measure_visitor).once.returns(mock(:visit))
        el(<<-XML).accept(@v)
          <dummy objectiveID="dummy">
            <imsss:minNormalizedMeasure />
          </dummy>
        XML
      end

      test 'a visitor visits multiple <mapInfo>s' do
        map_info_visitor = mock()
        map_info_visitor.expects(:visit).twice
        @v.expects(:map_info_visitor).twice.returns(map_info_visitor)
        el(<<-XML).accept(@v)
          <dummy objectiveID="dummy">
            <imsss:mapInfo />
            <imsss:mapInfo />
          </dummy>
        XML
      end
    end
  end
end
