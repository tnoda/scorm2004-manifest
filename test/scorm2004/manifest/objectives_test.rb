require_relative '../../helper'

module Scorm2004
  module Manifest
    class ObjectivesTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Objectives.new
        @v.stubs(:primary_objective_visitor).returns(stub(:visit))
        @v.stubs(:objective_visitor).returns(stub(:visit))
      end
      
      test 'an empty element causes error' do
        assert_raise(Objectives::Error) { el.accept(@v) }
      end

      test 'a minimal element' do
        assert_nothing_raised { el('<dummy><imsss:primaryObjective />').accept(@v) }
      end

      test 'a fat element' do
        objective_visitor = mock()
        objective_visitor.expects(:visit).twice
        @v.expects(:objective_visitor).twice.returns(objective_visitor)
        @v.expects(:primary_objective_visitor).once.returns(mock(:visit))
        el(<<-XML).accept(@v)
          <dummy>
            <imsss:primaryObjective />
            <imsss:objective />
            <imsss:objective />
          </dummy>
        XML
      end
    end
  end
end
