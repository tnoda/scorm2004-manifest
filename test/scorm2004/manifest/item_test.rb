require_relative '../../helper'

module Scorm2004
  module Manifest
    class ItemTest < ActiveSupport::TestCase
      include PartialManifest
      
      context 'an <item> visitor' do
        setup do
          @v = Item.new
          stubify(@v)
        end

        context 'with expectations visiting a fully-equipped <item> element' do
          setup do
            %w( title time_limit_action data_from_lms completion_threshold
                sequencing presentation data ).each do |singular|
              @v.expects("#{singular}_visitor".intern).once.returns(mock(:visit))
            end
            item_visitor = mock()
            item_visitor.expects(:visit).twice
            @v.expects(:item_visitor).twice.returns(item_visitor)
            el(<<-XML).accept(@v)
              <item identifier="i92"
                    identifierref="r25"
                    isvisible="false"
                    parameters="?foo=bar#baz">
                <title />
                <item />
                <item />
                <adlcp:timeLimitAction />
                <adlcp:dataFromLMS />
                <adlcp:completionThreshold />
                <imsss:sequencing />
                <adlnav:presentation />
                <adlcp:data />
              </item>
              <resources>
                <resource identifier="r25" />
              </resources>    
            XML
          end

          should 'satisfy expectations' do
            assert @v
          end

          should 'set an identifier value as its attribute' do
            assert_equal 'i92', @v.identifier
          end

          should 'set an identifierref value as its attribute' do
            assert_equal 'r25', @v.identifierref
          end

          should 'set an isvisible value as its attribute' do
            assert_equal false, @v.isvisible
          end

          should 'set a paramters value as its attribute' do
            assert_equal '?foo=bar#baz', @v.parameters
          end
        end

        context 'visiting a bare <item> element' do
          should 'set default values as its attributes' do
            el('<item identifier="r26"><title /><item /></item>').accept(@v)
            assert_equal "r26", @v.identifier
            assert_equal nil,   @v.identifierref
            assert_equal true,  @v.isvisible
            assert_equal nil,   @v.parameters
          end
        end
      end

      private

      def stubify(visitor)
        %w( title item time_limit_action data_from_lms completion_thoreshold
            sequencing presentation data ).each do |child|
          visitor.stubs("#{child}_visitor".intern).returns(stub(:visit))
        end
      end
    end
  end
end
