require_relative '../../helper'

module Scorm2004
  module Manifest
    class OrganizationTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'an organization visitor with its parent no base' do
        setup do
          @v = Organization.new
          @v.stubs(:item_visitor).returns(stub(:visit))
          @v.stubs(:title_visitor).returns(stub(:visit))
          @v.stubs(:completion_threshold_visitor).returns(stub(:visit))
          @v.stubs(:sequencing_visitor).returns(stub(:visit))
        end

        context 'visiting a fully equipped element' do
          setup do
            item_visitor = mock()
            item_visitor.expects(:visit).twice
            @v.expects(:item_visitor).twice.returns(item_visitor)
            @v.expects(:title_visitor).once.returns(mock(:visit))
            @v.expects(:completion_threshold_visitor).once.returns(mock(:visit))
            @v.expects(:sequencing_visitor).once.returns(mock(:visit))
            el(<<-XML).accept(@v)
              <organization identifier="toc1"
                            adlseq:objectivesGlobalToSystem=" false "
                            adlcp:sharedDataGlobalToSystem=" 0 ">
                <item />
                <item />
                <title />
                <adlcp:completionThreshold />
                <imsss:sequencing />
              </organization>
            XML
          end

          should 'set an identifier value as its attribute' do
            assert_equal 'toc1', @v.identifier
          end

          should 'set an objectivesGlobalToSystem value as its attribute' do
            assert_equal false, @v.objectives_global_to_system
          end

          should 'set a sharedDataGlobalToSystem value as its attribute' do
            assert_equal false, @v.shared_data_global_to_system
          end
        end

        context 'visiting an element with optional attributes missing' do
          setup do
            el(<<-XML).accept(@v)  
              <organization identifier="toc1">
                <item />
                <item />
                <title />
              </organization>
            XML
          end

          should 'set default values as the optional attributes' do
            assert_equal false, @v.objectives_global_to_system
            assert_equal false, @v.shared_data_global_to_system
          end
        end

        context 'visiting an element without an item element' do
          should 'raise exception' do
            assert_error do
              el('<organization identifier="b00"><title /></organization>').accept(@v)
            end
          end
        end

        context 'visiting an element without a title element' do
          should 'raise exception' do
            assert_error do
              el('<organization identifier="b11"><item /></organization').accept(@v)
            end
          end
        end
      end

      context 'an organization visitor with its parent having XML Base' do
        setup do
          @v = Organization.new(base: Pathname('path/to/base'))
          @v.stubs(:item_visitor).returns(stub(:visit))
          @v.stubs(:title_visitor).returns(stub(:visit))
        end

        context 'visiting a minimal organization element with XML Base' do
          should 'handle xml:base' do
            el(<<-XML).accept(@v)
              <organization identifier="toc2" xml:base="x/y/z/">
                <item />
                <title />
              </organization>
            XML
            assert_equal Pathname('path/to/base/x/y/z'), @v.base
          end
        end
      end

      private

      def assert_error(&block)
        assert_raise(Organization::Error, &block)
      end
    end
  end
end

#  LocalWords:  el toc adlseq objectivesGlobalToSystem adlcp imsss
#  LocalWords:  sharedDataGlobalToSystem completionThreshold
