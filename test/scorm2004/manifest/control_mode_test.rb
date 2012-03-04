require_relative '../../helper'

module Scorm2004
  module Manifest
    class ControlModeTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = ControlMode.new
      end
      
      test 'default values' do
        el('<dummy />').accept(@v)
        assert_equal true,  @v.choice
        assert_equal true,  @v.choice_exit
        assert_equal false, @v.flow
        assert_equal false, @v.forward_only
        assert_equal true,  @v.use_current_attempt_objective_info
        assert_equal true,  @v.use_current_attempt_progress_info
      end

      test 'attributes' do
        el(<<-XML).accept(@v)
          <dummy
            choice="0"
            choiceExit="0"
            flow="1"
            forwardOnly="1"
            useCurrentAttemptProgressInfo="0"
            useCurrentAttemptObjectiveInfo="0" />
        XML
        assert_equal false, @v.choice
        assert_equal false, @v.choice_exit
        assert_equal true,  @v.flow
        assert_equal true,  @v.forward_only
        assert_equal false, @v.use_current_attempt_objective_info
        assert_equal false, @v.use_current_attempt_progress_info
      end
    end
  end
end
