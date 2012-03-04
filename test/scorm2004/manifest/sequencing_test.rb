require_relative '../../helper'

module Scorm2004
  module Manifest
    class SequencingTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Sequencing.new
      end
      
      test 'an empty element' do
        assert el('<dummy />').accept(@v)
      end

      test 'ID attribute' do
        el('<dummy ID="foo" />').accept(@v)
        assert_equal 'foo', @v.id
      end

      test 'an element with children' do
        %w( control_mode sequencing_rules limit_conditions rollup_rules objectives randomization_controls delivery_controls constrained_choice_considerations rollup_considerations adlseq_objectives ).each do |child|
          @v.expects("#{child}_visitor".intern).once.returns(mock(:visit))
        end
        assert el(<<-XML).accept(@v)
          <dummy>
            <imsss:controlMode />
            <imsss:sequencingRules />
            <imsss:limitConditions />
            <imsss:rollupRules />
            <imsss:objectives />
            <imsss:randomizationControls />
            <imsss:deliveryControls />
            <adlseq:constrainedChoiceConsiderations />
            <adlseq:rollupConsiderations />
            <adlseq:objectives />
          </dummy>
        XML
      end
    end
  end
end
