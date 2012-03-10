require_relative '../../helper'

module Scorm2004
  module Manifest
    class AdlseqObjectiveTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = AdlseqObjective.new
      end
      
      test 'an empty element causes error' do
        assert_error { el.accept @v }
      end

      test 'an element must have the objectiveID attribute' do
        assert_error { el('<dummy><adlseq:mapInfo /></dummy').accept @v }
      end

      test 'an element must have at least one <adlseq:mapInfo>' do
        assert_error { el('<dummy objectiveID="foo" />').accept @v }
      end

      test 'a valid element' do
        map_info_visitor = mock()
        map_info_visitor.expects(:visit).twice
        @v.expects(:adlseq_map_info_visitor).twice.returns(map_info_visitor)
        el(<<-XML).accept @v
          <dummy objectiveID="bar">
            <adlseq:mapInfo />
            <adlseq:mapInfo />
          </dummy>
        XML
        assert_equal 'bar', @v.objective_id
      end

      private

      def assert_error &block
        assert_raise AdlseqObjective::Error, &block
      end
    end
  end
end
