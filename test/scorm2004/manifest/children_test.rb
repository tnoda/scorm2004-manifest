require_relative '../../helper'

module Scorm2004
  module Manifest
    class Son
      include VisitorPattern
    end

    class Grandson
      include VisitorPattern
    end

    class ChildrenTest < ActiveSupport::TestCase
      include PartialManifest

      context 'visitor that has one and only one child' do
        class VisitorHasOneAndOnlyOneChild
          include VisitorPattern
          include Children

          has_one_and_only_one('imscp:son')
        end

        setup do
          @v = VisitorHasOneAndOnlyOneChild.new
        end

        context 'visiting an element with one child' do
          should 'visit the only one child' do
            @v.expects(:visit_son).once
            assert el('<dummy><son /></dummy>').accept(@v)
          end

          should 'provide an accessor method for the child' do
            el('<dummy><son /></dummy>').accept(@v)
            assert @v.respond_to?(:son)
            assert_kind_of Son, @v.son
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:son_visitor).once.returns(mock(:visit))
            el('<dummy><son /></dummy>').accept(@v)
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
  <son />
  <son />
</dummy>
XML
            end
          end
        end
      end

      context 'visitor that has zero or one child' do
        class VisitorHasZeroOrOneChild
          include VisitorPattern
          include Children

          has_zero_or_one('imscp:son')
        end

        setup do
          @v = VisitorHasZeroOrOneChild.new
        end

        context 'visiting an element with one child' do
          should 'visit the only one child' do
            @v.expects(:visit_son).once
            assert el('<dummy><son /></dummy>').accept(@v)
          end

          should 'provide an accessor method for the child' do
            el('<dummy><son /></dummy>').accept(@v)
            assert @v.respond_to?(:son)
            assert_kind_of Son, @v.son
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:son_visitor).once.returns(mock(:visit))
            el('<dummy><son /></dummy>').accept(@v)
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
  <son />
  <son />
</dummy>
XML
            end
          end
        end
      end

      context 'visitor that has one or more children' do
        class VisitorHasOneOrMoreChildren
          include VisitorPattern
          include Children

          has_one_or_more('imscp:son')
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
            @v.expects(:visit_sons)
            assert el('<dummy><son /></dummy>').accept(@v)
          end

          should 'provide an accessor method for children' do
            el('<dummy><son /></dummy>').accept(@v)
            assert_kind_of Array, @v.sons
            assert_equal 1, @v.sons.size
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:son_visitor).once.returns(mock(:visit))
            el('<dummy><son /></dummy>').accept(@v)
          end
        end
        
        context 'visiting an element with two children' do
          should 'visit the children' do
            @v.expects(:visit_sons)
            assert el(<<XML).accept(@v)
<dummy>
  <son />
  <son />
</dummy>
XML
          end

          should 'provide an accessor method for children' do
            assert el(<<XML).accept(@v)
<dummy>
  <son />
  <son />
</dummy>
XML
            assert_kind_of Array, @v.sons
            assert_equal 2, @v.sons.size
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:son_visitor).twice.returns(stub(:visit))
            assert el(<<XML).accept(@v)
<dummy>
  <son />
  <son />
</dummy>
XML
          end
        end
      end

      context 'visitor that has zero or more children' do
        class VisitorHasZeroOrMoreChildren
          include VisitorPattern
          include Children

          has_zero_or_more('imscp:son')
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
            @v.expects(:visit_sons)
            assert el('<dummy><son /></dummy>').accept(@v)
          end

          should 'provide an accessor method for children' do
            el('<dummy><son /></dummy>').accept(@v)
            assert_kind_of Array, @v.sons
            assert_equal 1, @v.sons.size
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:son_visitor).once.returns(mock(:visit))
            el('<dummy><son /></dummy>').accept(@v)
          end
        end
        
        context 'visiting an element with two children' do
          should 'visit the children' do
            @v.expects(:visit_sons)
            assert el(<<XML).accept(@v)
<dummy>
  <son />
  <son />
</dummy>
XML
          end

          should 'provide an accessor method for children' do
            assert el(<<XML).accept(@v)
<dummy>
  <son />
  <son />
</dummy>
XML
            assert_kind_of Array, @v.sons
            assert_equal 2, @v.sons.size
          end

          should 'call a visitor factory method during the visit' do
            @v.expects(:son_visitor).twice.returns(stub(:visit))
            assert el(<<XML).accept(@v)
<dummy>
  <son />
  <son />
</dummy>
XML
          end
        end
      end

      context 'visitor has one grandson' do
        class VisitorHasOneGrandson
          include VisitorPattern
          include Children

          has_one_and_only_one './imscp:son/imscp:grandson'
        end

        setup do
          @v = VisitorHasOneGrandson.new
        end

        should 'raise exception if the grandson does not exist' do
          assert_raise VisitorHasOneGrandson::Error do
            el('<dummy><grandson /></dummy>').accept(@v)
          end
        end

        should 'visit the grandson' do
          el(<<-XML).accept(@v)
            <dummy>
              <son>
                <grandson />
              </son>
            </dummy>
          XML
          assert_kind_of Grandson, @v.grandson
        end

        should 'call the grandson_visitor method during the visit' do
          @v.expects(:grandson_visitor).once.returns(mock(:visit))
          el(<<-XML).accept(@v)
            <dummy>
              <son>
                <grandson />
              </son>
            </dummy>
          XML
        end
      end

      context 'a visitor with the visitor option' do
        class NamespacedVisitor
          include VisitorPattern
          include Children

          has_one_and_only_one 'imscp:foo', visitor: :foo_bar
        end
        
        setup do
          @v = NamespacedVisitor.new
          @v.expects(:foo_bar_visitor).once.returns(mock(:visit))
        end

        should 'visits a child element using the visitor' do
          el('<dummy><foo /></dummy>').accept(@v)
        end
      end
    end
  end
end
