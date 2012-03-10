require_relative '../../helper'

module Scorm2004
  module Manifest
    class AdlseqObjectivesTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = AdlseqObjectives.new
      end
      
      test 'an empty element cause error' do
        assert_raise(AdlseqObjectives::Error) { el.accept @v }
      end

      test 'visiting multiple <adlseq:objective>' do
        objective_visitor = mock()
        objective_visitor.expects(:visit).twice
        @v.expects(:adlseq_objective_visitor).twice.returns(objective_visitor)
        el(<<-XML).accept @v
          <dummy>
            <adlseq:objective />
            <adlseq:objective />
          </dummy>
        XML
      end
    end
  end
end
