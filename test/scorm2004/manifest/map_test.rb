require_relative '../../helper'

module Scorm2004
  module Manifest
    class MapTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Map.new
      end
      
      test 'an empty element' do
        assert_raise Map::Error do
          el('<dummy />').accept(@v)
        end
      end

      test 'default value' do
        el('<dummy targetID="dummy" />').accept(@v)
        assert_equal true, @v.read_shared_data
        assert_equal true, @v.write_shared_data
      end

      test 'attributes' do
        el('<dummy targetID="foo" readSharedData="0" writeSharedData="0" />').accept(@v)
        assert_equal 'foo', @v.target_id
        assert_equal false, @v.read_shared_data
        assert_equal false, @v.write_shared_data
      end
    end
  end
end
