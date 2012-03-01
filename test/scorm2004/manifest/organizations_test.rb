require_relative '../../helper'

module Scorm2004
  module Manifest
    class OrganizationsTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'an organizations visitor' do
        setup do
          @v = Organizations.new
          @v.stubs(:organization_visitor).returns(stub(:visit))
        end

        context 'visiting an organizations element' do
          should 'set the default value as its attribute' do
            organization_visitor = mock()
            organization_visitor.expects(:visit).twice
            @v.expects(:organization_visitor).twice.returns(organization_visitor)
            el(<<-XML).accept(@v)
              <organizations default="t41">
                <organization identifier="t41" />
                <organization identifier="t42" />
              </organizations>
            XML
            assert_equal 't41', @v.default
          end
        end

        context 'visiting an organizations element without a default attribute' do
          should 'raise exceptoin' do
            assert_error do
              el('<organizations />').accept(@v)
            end
          end
        end

        context 'visiting an organizations element with its default organization not found' do
          should 'raise exception' do
            assert_error do
              el('<organization default="t41" />').accept(@v)
            end
          end
        end
      end

      context 'an organization visitor with its parent having an XML Base value' do
        context 'visiting an organizations element' do
          should 'handle XML Base' do
            @v = Organizations.new(base: Pathname('a/b/c'))
            @v.stubs(:organization_visitor).returns(stub(:visit))
            el(<<-XML).accept(@v)
              <organizations default="t41" xml:base="x/y/z/">
                <organization identifier="t41" />
              </organizations>
            XML
            assert_equal Pathname('a/b/c/x/y/z'), @v.base
          end
        end
      end

      private

      def assert_error(&block)
        assert_raise Organizations::Error, &block
      end
    end
  end
end
