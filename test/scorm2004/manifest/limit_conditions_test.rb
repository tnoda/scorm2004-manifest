require_relative '../../helper'

module Scorm2004
  module Manifest
    class LimitConditionsTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = LimitConditions.new
      end
      
      test 'an empty element' do
        assert el('<dummy />').accept(@v)
      end

      %w( 0 1 001 +41 001002 ).each do |valid_number|
        tag = "<dummy attemptLimit='#{valid_number}' />"
        test tag do
          el(tag).accept(@v)
          assert_equal Integer(valid_number, 10), @v.attempt_limit
        end
      end

      %w( -1 +0.1 1.000 ).each do |invalid_number|
        tag = "<dummy attemptLimit='#{invalid_number}' />"
        test tag do
          assert_raise LimitConditions::Error do
            el(tag).accept(@v)
          end
        end
      end
    end
  end
end
