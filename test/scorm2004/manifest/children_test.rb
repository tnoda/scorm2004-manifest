require_relative '../../helper'

module Scorm2004
  module Manifest
    class ChildrenTestVisitor
      include VisitorPattern
    end

    class ChildrenTest < ActiveSupport::TestCase
      include PartialManifest

      context 'visitor that has one and only one child' do
        class VisitorHasOneAndOnlyOneChild
          include VisitorPattern
          include CustomError
          include Children

          has_one_and_only_one('imscp:childrenTest')
        end

        setup do
          @v = VisitorHasOneAndOnlyOneChild.new
        end

        context 'visiting an element with one child' do
          should 'visit the only one child' do
            @v.expects(:visit_children_test).once
            assert el('<dummy><childrenTest /></dummy>').accept(@v)
          end

          should 'provide an accessor method for the child' do
            el('<dummy><childrenTest /></dummy>').accept(@v)
            assert @v.respond_to?(:children_test)
            assert_kind_of ChildrenTestVisitor, @v.children_test
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:children_test_visitor).once.returns(mock(:visit))
            el('<dummy><childrenTest /></dummy>').accept(@v)
          end
        end

        context 'visiting an element without the child' do
          should 'raise exception' do
            assert_raise VisitorHasOneAndOnlyOneChild::Error do
              el('<dummy />').accept(@v)
            end
          end
        end

        context 'visiting an element with two children' do
          should 'raise exception' do
            assert_raise VisitorHasOneAndOnlyOneChild::Error do
              el(<<XML).accept(@v)
<dummy>
  <childrenTest />
  <childrenTest />
</dummy>
XML
            end
          end
        end
      end

      context 'visitor that has zero or one child' do
        class VisitorHasZeroOrOneChild
          include VisitorPattern
          include CustomError
          include Children

          has_zero_or_one('imscp:childrenTest')
        end

        setup do
          @v = VisitorHasZeroOrOneChild.new
        end

        context 'visiting an element with one child' do
          should 'visit the only one child' do
            @v.expects(:visit_children_test).once
            assert el('<dummy><childrenTest /></dummy>').accept(@v)
          end

          should 'provide an accessor method for the child' do
            el('<dummy><childrenTest /></dummy>').accept(@v)
            assert @v.respond_to?(:children_test)
            assert_kind_of ChildrenTestVisitor, @v.children_test
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:children_test_visitor).once.returns(mock(:visit))
            el('<dummy><childrenTest /></dummy>').accept(@v)
          end
        end

        context 'visiting an element without the child' do
          should 'raise nothing' do
            assert_nothing_raised do
              el('<dummy />').accept(@v)
            end
          end
        end

        context 'visiting an element with two children' do
          should 'raise exception' do
            assert_raise VisitorHasZeroOrOneChild::Error do
              el(<<XML).accept(@v)
<dummy>
  <childrenTest />
  <childrenTest />
</dummy>
XML
            end
          end
        end
      end

      context 'visitor that has one or more children' do
        class VisitorHasOneOrMoreChildren
          include VisitorPattern
          include CustomError
          include Children

          has_one_or_more('imscp:childrenTest')
        end

        setup do
          @v = VisitorHasOneOrMoreChildren.new
        end

        context 'visiting an element without a child' do
          should 'raise exception' do
            assert_raise VisitorHasOneOrMoreChildren::Error do
              el('<dummy />').accept(@v)
            end
          end
        end

        context 'visiting an element with a child' do
          should 'visit the child' do
            @v.expects(:visit_children_tests)
            assert el('<dummy><childrenTest /></dummy>').accept(@v)
          end

          should 'provide an accessor method for children' do
            el('<dummy><childrenTest /></dummy>').accept(@v)
            assert_kind_of Array, @v.children_tests
            assert_equal 1, @v.children_tests.size
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:children_test_visitor).once.returns(mock(:visit))
            el('<dummy><childrenTest /></dummy>').accept(@v)
          end
        end
        
        context 'visiting an element with two children' do
          should 'visit the children' do
            @v.expects(:visit_children_tests)
            assert el(<<XML).accept(@v)
<dummy>
  <childrenTest />
  <childrenTest />
</dummy>
XML
          end

          should 'provide an accessor method for children' do
            assert el(<<XML).accept(@v)
<dummy>
  <childrenTest />
  <childrenTest />
</dummy>
XML
            assert_kind_of Array, @v.children_tests
            assert_equal 2, @v.children_tests.size
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:children_test_visitor).twice.returns(stub(:visit))
            assert el(<<XML).accept(@v)
<dummy>
  <childrenTest />
  <childrenTest />
</dummy>
XML
          end
        end
      end

      context 'visitor that has zero or more children' do
        class VisitorHasZeroOrMoreChildren
          include VisitorPattern
          include CustomError
          include Children

          has_zero_or_more('imscp:childrenTest')
        end

        setup do
          @v = VisitorHasZeroOrMoreChildren.new
        end

        context 'visiting an element without a child' do
          should 'not raise exception' do
            assert_nothing_raised do
              el('<dummy />').accept(@v)
            end
          end
        end

        context 'visiting an element with a child' do
          should 'visit the child' do
            @v.expects(:visit_children_tests)
            assert el('<dummy><childrenTest /></dummy>').accept(@v)
          end

          should 'provide an accessor method for children' do
            el('<dummy><childrenTest /></dummy>').accept(@v)
            assert_kind_of Array, @v.children_tests
            assert_equal 1, @v.children_tests.size
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:children_test_visitor).once.returns(mock(:visit))
            el('<dummy><childrenTest /></dummy>').accept(@v)
          end
        end
        
        context 'visiting an element with two children' do
          should 'visit the children' do
            @v.expects(:visit_children_tests)
            assert el(<<XML).accept(@v)
<dummy>
  <childrenTest />
  <childrenTest />
</dummy>
XML
          end

          should 'provide an accessor method for children' do
            assert el(<<XML).accept(@v)
<dummy>
  <childrenTest />
  <childrenTest />
</dummy>
XML
            assert_kind_of Array, @v.children_tests
            assert_equal 2, @v.children_tests.size
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:children_test_visitor).twice.returns(stub(:visit))
            assert el(<<XML).accept(@v)
<dummy>
  <childrenTest />
  <childrenTest />
</dummy>
XML
          end
        end
      end
    end
  end
end
