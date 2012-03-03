require_relative '../../helper'

module Scorm2004
  module Manifest
    class HideLmsuiTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = HideLmsui.new
      end
      
      HideLmsui.vocabulary.each do |token|
        tag ="<adlnav:hideLMSUI>#{token}</adlnav:hideLMSUI>" 
        test tag do
          el(tag).accept(@v)
          assert_equal token, @v.content
          assert_equal @v.content, @v.to_s
        end
      end

      test 'an empty element' do
        assert_error do
          el('<dummy />').accept(@v)
        end
      end

      test 'an element with an invalid token' do
        assert_error do
          el('<dummy>invalidToken</dummy').accept(@v)
        end
      end

      private

      def assert_error(&block)
        assert_raise HideLmsui::Error, &block
      end
    end
  end
end
