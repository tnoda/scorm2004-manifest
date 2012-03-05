require_relative '../../helper'

module Scorm2004
  module Manifest
    class MapInfoTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = MapInfo.new
      end
      
      test 'an empty element causes error' do
        assert_raise(MapInfo::Error) { el.accept(@v) }
      end

      test 'default value' do
        el('<dummy targetObjectiveID="dummy" />').accept(@v)
        assert_equal true, @v.read_satisfied_status
        assert_equal true, @v.read_normalized_measure
        assert_equal false, @v.write_satisfied_status
        assert_equal false, @v.write_normalized_measure
      end

      test 'a visitor set attribute values as its attributes' do
        el(<<-XML).accept(@v)
          <dummy
            targetObjectiveID="bar"
            readSatisfiedStatus="0"
            readNormalizedMeasure="0"
            writeSatisfiedStatus="1"
            writeNormalizedMeasure="1" />
        XML
        assert_equal 'bar', @v.target_objective_id
        assert_equal false, @v.read_satisfied_status
        assert_equal false, @v.read_normalized_measure
        assert_equal true, @v.write_satisfied_status
        assert_equal true, @v.write_normalized_measure
      end
    end
  end
end
