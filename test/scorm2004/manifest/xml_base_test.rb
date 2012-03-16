require_relative '../../helper'

module Scorm2004
  module Manifest
    class XmlBaseTest < ActiveSupport::TestCase
      include PartialManifest
      
      class Visitor
        include VisitorPattern
        include XmlBase
      end

      context 'visitor with its parent base nil' do
        setup do
          @v = Visitor.new(base: nil)
        end

        context 'visiting a node with xml:base beginning leading a slash' do
          should 'raise exception' do
            el('<dummy xml:base="/path/to/dir/" />').accept(@v)
            assert_raise Visitor::Error do
              @v.base
            end
          end
        end

        context 'visiting a node without xml:base trailing a slash' do
          should 'raise exception' do
            el('<dummy xml:base="http://exampe.com/a" />').accept(@v)
            assert_raise Visitor::Error do
              @v.base
            end
          end
        end

        context 'visiting a node without xml:base' do
          should 'set nil as its base' do
            el('<dummy />').accept(@v)
            assert_nil @v.base
          end
        end

        context 'visiting a node with a URI xml:base' do
          should 'set the uri as its base' do
            el('<dummy xml:base="http://example.com/path/to/file/" />').accept(@v)
            assert_equal URI('http://example.com/path/to/file/'), @v.base
          end
        end

        context 'visiting a node with a pathname xml:base' do
          should 'set the pathname as its base' do
            el('<dummy xml:base="path/to/dir/" />').accept(@v)
            assert_equal Pathname('path/to/dir'), @v.base
          end
        end

        context 'visiting a node with a relative-path xml:base' do
          should 'set normalized pathname as its base' do
            el('<dummy xml:base="../../path/to/dir/" />').accept(@v)
            assert_equal Pathname('path/to/dir'), @v.base
          end
        end
      end

      context 'visitor with its parent base an absolute URL' do
        setup do
          @parent_base = URI('http://example.com/a/')
          @v = Visitor.new(base: @parent_base)
        end

        context 'visiting a node without xml:base' do
          should 'set the parent base as its base' do
            el('<dummy />').accept(@v)
            assert_equal @parent_base, @v.base
          end
        end
        
        context 'visiting a node with a relateve URL' do
          should 'set a resolved URI as its base' do
            el('<dummy xml:base="../../x/" />').accept(@v)
            assert_equal URI('http://example.com/x/'), @v.base
          end
        end
        
        context 'visiting a node with a absolute URL' do
          should 'set its XML Base value as its base' do
            absolute_url = 'http://example.net/b/'
            el("<dummy xml:base='#{absolute_url}' />").accept(@v)
            assert_equal URI(absolute_url), @v.base
          end
        end
      end

      context 'visitor with its parent base a relative URL' do
        setup do
          @parent_path = Pathname('a/b/c')
          @v = Visitor.new(base: Pathname(@parent_path))
        end
        
        context 'visiting a node without xml:base' do
          should 'set the parent base as its base' do
            el('<dummy />').accept(@v)
            assert_equal @parent_path, @v.base
          end
        end

        context 'visiting a node with an absolute URL' do
          should 'set its XML Base value as its base' do
            absolute_url = URI('http://example.org/x/y/z/')
            el("<dummy xml:base='#{absolute_url}' />").accept(@v)
            assert_equal absolute_url, @v.base
          end
        end

        context 'visiting a node with a relative URL' do
          should 'set a resolved URL as its base' do
            el('<dummy xml:base="x/y/z/" />').accept(@v)
            assert_equal Pathname('a/b/c/x/y/z'), @v.base
          end
        end
      end
    end
  end
end
