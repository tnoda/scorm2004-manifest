require_relative '../../helper'

module Scorm2004
  module Manifest
    class TitleTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'a title visitor' do
        setup do
          @v = Title.new
        end

        context 'visiting a title' do
          setup do
            @title_content = 'a sample title'
            el("<title>#{@title_content}</title>").accept(@v)
          end

          should 'respond to content' do
            assert @v.respond_to? :content
          end

          should 'also respond to to_s that aliases content' do
            assert @v.respond_to? :to_s
            assert_equal @v.content, @v.to_s
          end

          should 'set a content as its attribute' do
            assert_equal @title_content, @v.content
          end
        end

        context 'visiting a too long title' do
          should 'raise exception' do
            assert_error do
              el('<title>' + 'x' * 201 + '</title').accept(@v)
            end
          end
        end

        context 'visiting an empty title element' do
          should 'raise exception' do
            assert_error do
              el('<title />').accept(@v)
            end
          end
        end
      end

      private

      def assert_error(&block)
        assert_raise Title::Error, &block
      end
    end
  end
end

#  LocalWords:  TitleTest PartialManifest el
