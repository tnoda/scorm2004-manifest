require_relative '../../helper'

module Scorm2004
  module Manifest
    class RandomizationControlsTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RandomizationControls.new
      end
      
      test 'default values' do
        el.accept(@v)
        assert_equal 'never', @v.randomization_timing
        assert_equal false,   @v.reorder_children
        assert_equal 'never', @v.selection_timing
      end

      RandomizationControls::TIMINGS.each do |timing|
        tag = "<dummy randomizationTiming='#{timing}' />"
        test tag do
          el(tag).accept(@v)
          assert_equal timing, @v.randomization_timing
        end
      end

      RandomizationControls::TIMINGS.each do |timing|
        tag = "<dummy selectionTiming='#{timing}' />"
        test tag do
          el(tag).accept(@v)
          assert_equal timing, @v.selection_timing
        end
      end

      test 'invalid randomizationTiming' do
        assert_error { el('<dummy randomizationTiming="invalid" />').accept(@v) }
      end

      test 'invalid selectionTiming' do
        assert_error { el('<dummy selectionTiming="invalid" />').accept(@v) }
      end

      1.upto(10) do |n|
        tag = "<dummy selectCount='#{n}' />"
        test tag do
          el(tag).accept(@v)
          assert_equal n, @v.select_count
        end
      end

      [-1, 1.000, 0.001].each do |invalid_value|
        tag = "<dummy selectCount='#{invalid_value}' />"
        test tag do
          assert_error { el(tag).accept(@v) }
        end
      end

      [true, false].each do |boolean|
        tag = "<dummy reorderChildren='#{boolean}' />"
        test tag do
          el(tag).accept(@v)
          assert_equal boolean, @v.reorder_children
        end
      end

      def assert_error(&block)
        assert_raise RandomizationControls::Error, &block
      end
    end
  end
end
