require_relative '../../helper'

module Scorm2004
  module Manifest
    class TimeLimitActionTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = TimeLimitAction.new
      end
      
      context 'a <adlcp:timeLimitAction> visitor' do
        should 'respond to :content' do
          @v.respond_to? :content
        end

        should 'respond to :to_s' do
          @v.respond_to? :to_s
        end
      end

      TimeLimitAction.vocabulary.each do |token|
        test "<adlcp:timeLimitAction>#{token}</adlcp:timieLimitAction>" do
          assert_nothing_raised do
            el("<dummy>#{token}</dummy").accept(@v)
          end
          assert_equal token, @v.content
          assert_equal @v.content, @v.to_s
        end
      end

      test 'an empty element causes error' do
        assert_error do
          el('<dummy />').accept(@v)
        end
      end

      test 'an invalid token causes error' do
        assert_error do
          el('<dummy>invalid token, error</dummy>').accept(@v)
        end
      end

      private

      def assert_error(&block)
        assert_raise TimeLimitAction::Error, &block
      end
    end
  end
end
