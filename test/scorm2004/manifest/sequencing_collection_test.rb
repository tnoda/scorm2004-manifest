require_relative '../../helper'

module Scorm2004
  module Manifest
    class SequencingCollectionTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = SequencingCollection.new
      end
      
      test 'an empety element' do
        assert_raise SequencingCollection::Error do
          el('<dummy />').accept(@v)
        end
      end

      test 'an elemeent with two sequencings' do
        sequencing_visitor = mock()
        sequencing_visitor.expects(:visit).twice
        @v.expects(:sequencing_visitor).twice.returns(sequencing_visitor)
        assert el(<<-XML).accept(@v)
          <dummy>
            <imsss:sequencing />
            <imsss:sequencing />
          </dummy>
        XML
      end
    end
  end
end
