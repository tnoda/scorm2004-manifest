require_relative '../../helper'

module Scorm2004
  module Manifest
    class ResourceTest < ActiveSupport::TestCase
      include PartialManifest
      
      VALID_RESOURCE_ELEMENT =<<-XML
        <resource identifier="a12"
                  href="path/to/file.html"
                  adlcp:scormType="sco" />
      XML

      context 'a resource visitor' do
        setup do
          @v = Resource.new(base: Pathname('path/to/base'))
        end

        context 'visiting a valid element' do
          should 'set its attribute properly' do
            el(VALID_RESOURCE_ELEMENT).accept(@v)
            assert_equal 'a12',                                      @v.identifier
            assert_equal Pathname('path/to/base/path/to/file.html'), @v.href
            assert_equal 'sco',                                      @v.scorm_type
          end
        end

        context 'visiting a valid element without href' do
          should 'raise nothing' do
            assert_nothing_raised do
              el('<resource identifier="a12" adlcp:scormType="sco" />').accept(@v)
            end
          end
        end

        context 'visiting an element without identifier' do
          should 'raise exception' do
            assert_error do
              el('<resource href="x" adlcp:scormType="sco" />').accept(@v)
            end
          end
        end

        context 'visiting an element without scormType' do
          should 'raise exceptoin' do
            assert_error do
              el('<resource identifier="b34" />').accept(@v)
            end
          end
        end

        context 'visiting an element with its scormType invalid' do
          should 'raise exception' do
            assert_error do
              el('<resource identifier="c56" adlcp:scormType="file" />').accept(@v)
            end
          end
        end

        context 'visiting an element with files' do
          should 'visit the files' do
            file_visitor = mock()
            file_visitor.expects(:visit).twice
            @v.expects(:file_visitor).twice.returns(file_visitor)
            el(<<-XML).accept(@v)
              <resource identifier="x01" adlcp:scormType="asset">
                <file />
                <file />
              </resource>
            XML
          end
        end

        context 'visiting an element with dependencies' do
          should 'visit the dependencies' do
            dependency_visitor = mock()
            dependency_visitor.expects(:visit).twice
            @v.expects(:dependency_visitor).twice.returns(dependency_visitor)
            el(<<-XML).accept(@v)
              <resource identifier="x01" adlcp:scormType="asset">
                <dependency />
                <dependency />
              </resource>
            XML
          end
        end
      end

      private

      def assert_error(&block)
        assert_raise Resource::Error, &block
      end
    end
  end
end
