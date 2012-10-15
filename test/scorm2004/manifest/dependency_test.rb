require_relative '../../helper'

module Scorm2004
  module Manifest
    class DependencyTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Dependency.new
      end
      
      context 'a dependency visitor' do
        setup do
          @v = Dependency.new
        end

        context 'visiting a dependency element' do
          should 'set an identifierref value as its attribute' do
            el(<<-XML).accept(@v)
              <dependency identifierref="k22" />
              <resources>
                <resource identifier="k22" />
              </resources>
            XML
            assert_equal 'k22', @v.identifierref
          end
        end

        context 'visiting a dependency element without an identifierref attribute' do
          should 'raise exception' do
            assert_error do
              el('<dependency />').accept(@v)
            end
          end
        end
      end

      private

      def assert_error(&block)
        assert_raise(Dependency::Error, &block)
      end
    end
  end
end
