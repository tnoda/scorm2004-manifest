require_relative '../../helper'

module Scorm2004
  module Manifest
    class VisitorPatternTest < ActiveSupport::TestCase
      class DumbVisitor
        include VisitorPattern
      end

      include PartialManifest
      
      context 'Visitor visiting a element' do
        setup do
          @v = DumbVisitor.new
          el('<dummy />').accept(@v)
        end

        should 'set a Nokogiri node as an attribute named el' do
          assert_kind_of Nokogiri::XML::Node, @v.el
        end

        should 'return self when visiting a element' do
          assert_equal @v, el('<dummy />').accept(@v)
        end
      end

      context 'Visitor with do_visit method' do
        setup do
          @v = DumbVisitor.new
          @v.expects(:do_visit)
        end

        should 'call do_visit method' do
          el('<dummy />').accept(@v)
        end
      end

      context 'Visitor with the attributes class method' do
        setup do
          @v = DumbVisitor.new
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
    end
  end
end
