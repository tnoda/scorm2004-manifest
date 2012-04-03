require_relative '../../helper'

module Scorm2004
  module Manifest
    class DataFromLmsTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = DataFromLms.new
      end
      
      context 'an <adlcp:dataFromLMS> visitor' do
        should 'respond to :content' do
          assert @v.respond_to? :content
        end

        should 'respond to :to_s' do
          assert @v.respond_to? :to_s
        end

        context 'visiting an empty element' do
          should 'return a blank string as its content' do
            el('<dummy />').accept(@v)
            assert_equal '', @v.content
            assert_equal @v.to_s, @v.content
          end
        end

        context 'visiting an element' do
          should 'return the content as its content' do
            el('<dummy>a sample content</dummy>').accept(@v)
            assert_equal 'a sample content', @v.content
            assert_equal @v.to_s, @v.content
          end
        end

        context 'visitng an element whose content is too large' do
          should 'raise exception' do
            assert_raise DataFromLms::Error do
              el('<dummy>' + 'x' * (DataFromLms::SPM + 1) + '</dummy>').accept(@v)
            end
          end
        end
      end
    end
  end
end
