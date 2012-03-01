require_relative '../../helper'

module Scorm2004
  module Manifest
    class CompletionThresholdTest < ActiveSupport::TestCase
      include PartialManifest
      
      
      context 'an <adlcp:completionThreshold> visitor' do
        setup do
          @v = CompletionThreshold.new
        end

        context 'visiting an <adlcp:completionThreshold> element' do
          setup do
            el(<<-XML).accept(@v)
              <adlcp:completionThreshold
               completedByMeasure = "true"
               minProgressMeasure = "0.75"
               progressWeight = "0.3" />
            XML
          end

          should 'set completedByMeasure value as its attribute' do
            assert_equal true, @v.completed_by_measure
          end

          should 'set minProgressMeasure value as its attribute' do
            assert_equal 0.75, @v.min_progress_measure
          end

          should 'set progressWeight value as its attribute' do
            assert_equal 0.3, @v.progress_weight
          end
        end

        context 'visiting an empty <adlcp:completionThreshold> element' do
          should 'set default values' do
            el('<adlcp:completionThreshold />').accept(@v)
            assert_equal false, @v.completed_by_measure
            assert_equal 1.0,  @v.min_progress_measure
            assert_equal 1.0,  @v.progress_weight
          end
        end

        context 'visiting an <adlcp:completionThreshold> element with its attribute value out of range' do
          should 'raise exception for too small minProgressMeasure' do
            assert_error do
              el('<adlcp:completionThreshold minProgressMeasure="-0.0001" />').accept(@v)
            end
          end

          should 'raise exception for too large minProgressMeasure' do
            assert_error do
              el('<adlcp:completionThreshold minProgressMeasure="1.0001" />').accept(@v)
            end
          end

          should 'raise exception for too small progressWeight' do
            assert_error do
              el('<adlcp:completionThreshold progressWeight="-0.0001" />').accept(@v)
            end
          end

          should 'raise exception for too large progressWeight' do
            assert_error do
              el('<adlcp:completionThreshold progressWeight="1.0001" />').accept(@v)
            end
          end
        end
      end

      private

      def assert_error(&block)
        assert_raise CompletionThreshold::Error, &block
      end
    end
  end
end
