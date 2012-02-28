require_relative '../../helper'

module Scorm2004
  module Manifest
    class ResourcesTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Resources.new
      end
      
      context 'a resources visitor' do
        should 'support xml:base' do
          assert @v.respond_to? :base
        end
      end

      context 'a resources visitor visiting an empty element' do
        should 'not raise exceptoin' do
          assert_nothing_raised do
            el('<dummy />').accept(@v)
          end
        end
      end

      context 'a resources visitor visiting an element with resource elements' do
        should 'visit these elements' do
          v = mock()
          v.expects(:visit).twice
          @v.expects(:resource_visitor).twice.returns(v)
          el(<<-XML).accept(@v)
            <dummy>
              <resource />
              <resource />
            </dummy>
          XML
        end
      end
    end
  end
end
