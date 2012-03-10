require_relative '../../helper'

module Scorm2004
  module Manifest
    class ConstrainedChoiceConsiderationsTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = ConstrainedChoiceConsiderations.new
      end
      
      test 'default values' do
        el.accept @v
        assert_equal false, @v.prevent_activation
        assert_equal false, @v.constrain_choice
      end

      test 'attributes' do
        el('<dummy preventActivation="1" constrainChoice="1" />').accept @v
        assert_equal true, @v.prevent_activation
        assert_equal true, @v.constrain_choice
      end
    end
  end
end
