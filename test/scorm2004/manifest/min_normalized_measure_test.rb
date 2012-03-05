require_relative '../../helper'

module Scorm2004
  module Manifest
    class MinNormalizedMeasureTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = MinNormalizedMeasure.new
      end
      
      [-1.0, 0, 1.0].each do |valid_value|
        tag = "<dummy>#{valid_value}</dummy>"
        test tag do
          el(tag).accept(@v)
          assert_equal valid_value, @v.to_f
        end
      end

      [-1.0001, 1.0001].each do |invalid_value|
        tag = "<dummy>#{invalid_value}</dummy>"
        test tag do
          assert_raise(MinNormalizedMeasure::Error) { el(tag).accept(@v) }
        end
      end
    end
  end
end
