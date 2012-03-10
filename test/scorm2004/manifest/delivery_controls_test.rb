require_relative '../../helper'

module Scorm2004
  module Manifest
    class DeliveryControlsTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = DeliveryControls.new
      end
      
      test 'default values' do
        el.accept @v
        assert_equal true, @v.tracked
        assert_equal false, @v.completion_set_by_content
        assert_equal false, @v.objective_set_by_content
      end

      test 'attributes' do
        el('<dummy tracked="0" completionSetByContent="1" objectiveSetByContent="1" />').accept @v
        assert_equal false, @v.tracked
        assert_equal true, @v.completion_set_by_content
        assert_equal true, @v.objective_set_by_content
      end
    end
  end
end
