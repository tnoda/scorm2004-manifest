require_relative '../../helper'

module Scorm2004
  module Manifest
    class FileTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'a file visitor with its parent no XML Base' do
        setup do
          @v = Scorm2004::Manifest::File.new
        end

        context 'visiting a file element' do
          should 'set an href value as its attribute' do
            el('<file href="path/to/file" />').accept(@v)
            assert_equal 'path/to/file', @v.href
          end
        end

        context 'visiting a file element without an href attribute' do
          should 'raise exception' do
            assert_raise Scorm2004::Manifest::File::Error do
              el('<file />').accept(@v)
            end
          end
        end
      end

      context 'a file visitor with its parent a path base' do
        context 'visiting a file element' do
          should 'set a resolved href value as its attribute' do
            @v = Scorm2004::Manifest::File.new(base: Pathname('path/to/base'))
            el('<file href="path/to/file" />').accept(@v)
            assert_equal 'path/to/base/path/to/file', @v.href
          end
        end
      end
    end
  end
end
