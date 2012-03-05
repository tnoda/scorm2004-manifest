require_relative '../../helper'

module Scorm2004
  module Manifest
    class PrimaryObjectiveTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = PrimaryObjective.new
        @v.stubs(:map_info_visitor).returns(stub(:visit))
      end
      
      test 'default satisfiedByMeasure' do
        el.accept(@v)
        assert_equal false, @v.satisfied_by_measure
      end

      test 'a visitor visits <minNormalizedMeasure>' do
        @v.expects(:min_normalized_measure_visitor).once.returns(mock(:visit))
        el('<dummy><imsss:minNormalizedMeasure /></dummy>').accept(@v)
      end

      test 'the objectiveID attribute' do
        el('<dummy objectiveID="foo" />').accept(@v)
        assert_equal 'foo', @v.objective_id
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

      test 'If an element contains an objective map, then the objectiveID attribute is required.' do
        assert_error do
          el(<<-XML).accept(@v)
            <dummy>
              <imsss:mapInfo />
            </dummy>
          XML
        end
      end

      test 'an element with both objectiveID and <mapInfo> does not cause error' do
        assert_nothing_raised do
          el(<<-XML).accept(@v)
            <dummy objectiveID="dummy">
              <imsss:mapInfo />
            </dummy>
          XML
        end
      end

      def assert_error(&block)
        assert_raise PrimaryObjective::Error, &block
      end
    end
  end
end
