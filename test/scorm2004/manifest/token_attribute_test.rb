require_relative '../../helper'

module Scorm2004
  module Manifest
    class TokenAttributeTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'visitor having a token attribute' do
        class VisitorHavingTokenAttribute
          include VisitorPattern
          include CustomError
          include Attributes

          attribute :token, 'foo', vocabulary: ['foo', 'bar', 'foo bar']
        end
        
        setup do
          @v = VisitorHavingTokenAttribute.new
        end

        context 'visiting an element without the attribute' do
          should 'raise exception' do
            assert_raise VisitorHavingTokenAttribute::Error do
              el('<dummy />').accept(@v)
            end
          end
        end

        context 'visiting an element with a valid token attribute' do
          should 'set the token as the value of the attribute' do
            el('<dummy foo="bar" />').accept(@v)
            assert_equal 'bar', @v.foo
          end
        end

        context 'visiting an element with an invalid token attribute' do
          should 'raise exception' do
            assert_raise VisitorHavingTokenAttribute::Error do
              el('<dummy foo="hoge" />').accept(@v)
            end
          end
        end

        context 'visiting an element with token attribute having leading and trailing spaces' do
          should 'remove these spaces' do
            el('<dummy foo=" 	 foo 	 bar	   " />').accept(@v)
            assert_equal 'foo bar', @v.foo
          end
        end
      end
    end
  end
end
