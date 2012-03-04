require_relative '../../helper'

module Scorm2004
  module Manifest
    class RuleActionTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RuleAction.new
      end
      
      test 'an empty element causes error' do
        assert_error do
          el('<dummy />').accept(@v)
        end
      end

      Scorm2004::Manifest::RuleAction::PRE.each do |token|
        tag = "<imsss:ruleAction action='#{token}' />"
        context tag do
          should 'be accepted if it is within <preConditionRule>.' do
            assert pre_el(tag).accept(@v)
          end

          should 'cause error if it is within either <postConditionRule> or <exitConditionRule>' do
            assert_error { post_el(tag).accept(@v) }
            assert_error { exit_el(tag).accept(@v) }
          end
        end
      end

      Scorm2004::Manifest::RuleAction::POST.each do |token|
        tag = "<imsss:ruleAction action='#{token}' />"
        context tag do
          should 'be accepted if it is within <postConditionRule>.' do
            assert post_el(tag).accept(@v)
          end

          should 'cause error if it is within either <preConditionRule> or <exitConditionRule>' do
            assert_error { pre_el(tag).accept(@v) }
            assert_error { exit_el(tag).accept(@v) }
          end
        end
      end

      Scorm2004::Manifest::RuleAction::EXIT.each do |token|
        tag = "<imsss:ruleAction action='#{token}' />"
        context tag do
          should 'be accepted if it is within <exitConditionRule>.' do
            assert exit_el(tag).accept(@v)
          end

          should 'cause error if it is within either <preConditionRule> or <postConditionRule>' do
            assert_error { pre_el(tag).accept(@v) }
            assert_error { post_el(tag).accept(@v) }
          end
        end
      end

      private

      def assert_error(&block)
        assert_raise RuleAction::Error, &block
      end

      def pre_el(xml)
        el("<imsss:preConditionRule>#{xml}</imsss:preConditionRule").at('./*')
      end

      def post_el(xml)
        el("<imsss:postConditionRule>#{xml}</imsss:postConditionRule").at('./*')
      end

      def exit_el(xml)
        el("<imsss:exitConditionRule>#{xml}</imsss:exitConditionRule").at('./*')
      end
    end
  end
end
