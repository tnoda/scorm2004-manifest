require_relative '../../helper'

module Scorm2004
  module Manifest
    class RollupActionTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RollupAction.new
      end
      
      test 'an empty element causes error' do
        assert_error { el.accept(@v) }
      end

      RollupAction::ACTIONS.each do |action|
        tag = "<dummy action='#{action}' />"
        test tag do
          el(tag).accept(@v)
          assert_equal action, @v.action
        end
      end

      test 'invalid action' do
        assert_error { el('<dummy action="invalid" />').accept(@v) }
      end

      def assert_error(&block)
        assert_raise RollupAction::Error, &block
      end
    end
  end
end
