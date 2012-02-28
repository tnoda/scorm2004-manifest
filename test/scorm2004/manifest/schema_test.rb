require_relative '../../helper'

module Scorm2004
  module Manifest
    class SchemaTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Schema.new
      end
      
      context 'a schema visitor visiting a valid element' do
        should 'not raise exception' do
          assert_nothing_raised do
            el('<dummy>ADL SCORM</dummy>').accept(@v)
          end
        end
      end

      context 'a schema visitor visiting an element with invalid schema' do
        should 'raise exception' do
          assert_raise Schema::Error do
            el('<dummy>SCORM</dummy>').accept(@v)
          end
        end
      end
    end
  end
end
