require_relative '../../helper'

module Scorm2004
  module Manifest
    class SchemaversionTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Schemaversion.new
      end
      
      context 'a schemaversion visitor visiting a valid element' do
        should 'not raise exceptoin' do
          assert_nothing_raised do
            el('<dummy>2004 4th Edition</dummy>').accept(@v)
          end
        end
      end

      context 'a schemaversion visitor visiting an element with invalid schemaversion' do
        should 'raise exception' do
          assert_raise Schemaversion::Error do
            el('<dummy>2004 3rd Edition</dummy>').accept(@v)
          end
        end
      end
    end
  end
end
