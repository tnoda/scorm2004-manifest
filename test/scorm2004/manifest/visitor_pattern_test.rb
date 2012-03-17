require_relative '../../helper'

module Scorm2004
  module Manifest
    class VisitorPatternTest < ActiveSupport::TestCase
      include PartialManifest

      class Visitor
        include VisitorPattern
      end
      
      context 'Visitor visiting a element' do
        setup do
          @v = Visitor.new
          el('<dummy />').accept(@v)
        end

        should 'set a Nokogiri node as an attribute named el' do
          assert_kind_of Nokogiri::XML::Node, @v.el
        end

        should 'return self when visiting a element' do
          assert_equal @v, el('<dummy />').accept(@v)
        end

        should 'not have metadata' do
          assert_equal nil, @v.metadata
        end
      end

      test 'metadata' do
        visitor = Visitor.new
        el('<a><metadata /></a>').accept visitor
        assert_kind_of Nokogiri::XML::Node, visitor.metadata
        assert_equal 'metadata', visitor.metadata.name
      end

      context 'Visitor with do_visit method' do
        class PrivateDoVisit
          include VisitorPattern

          private

          def do_visit
            do_visit_probe
          end
        end

        setup do
          @v = PrivateDoVisit.new
          @v.expects(:do_visit_probe)
        end

        should 'call do_visit method' do
          el('<dummy />').accept(@v)
        end
      end

      context 'Visitor with the attributes class method' do
        setup do
          @v = Visitor.new
          @v.class.stubs(:attributes)
        end

        should 'call the check_attributes method when visiting an element' do
          @v.expects(:check_attributes)
          el('<dummy />').accept(@v)
        end

        should 'call check_foo if attributes include foo when visiting an element' do
          @v.class.stubs(:attributes).returns([:foo])
          @v.expects(:check_foo)
          el('<dummy />').accept(@v)
        end
      end

      context 'Visitor with the children class method' do
        setup do
          @v = Visitor.new
          @v.class.stubs(:children)
        end

        should 'call the visit_children method when visiting an element' do
          @v.expects(:visit_children)
          el('<dummy />').accept(@v)
        end

        should 'call visit_foo if children include foo when visiting an element' do
          @v.class.stubs(:children).returns([:foo])
          @v.expects(:visit_foo)
          el('<dummy />').accept(@v)
        end
      end
    end
  end
end
