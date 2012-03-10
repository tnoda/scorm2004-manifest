require_relative '../../helper'

module Scorm2004
  module Manifest
    class HrefTest < ActiveSupport::TestCase
      include PartialManifest
      
      class Visitor
        include VisitorPattern
        include CustomError
        include XmlBase
        include Href
      end

      context 'a visitor with its own base value' do
        setup do
          @v = Visitor.new(base: Pathname('a/b/c'))
        end

        context 'visiting an element with xml:base and href' do
          should 'calculate the resolved href properly' do
            el('<dummy xml:base="../../d/e/f/" href="x/y/z.html').accept(@v)
            assert_equal 'a/d/e/f/x/y/z.html', @v.href
          end
        end

        context 'visiting an element without href' do
          should 'return nil for href' do
            el('<dummy xml:base="../../d/e/f/" />').accept(@v)
            assert_nil @v.href
          end
        end

        context 'visiting an element with href' do
          should 'calculate the resolved href properly' do
            el('<dummy href="../../x/y/z.html" />').accept(@v)
            assert_equal 'a/x/y/z.html', @v.href
          end
        end
      end
    end
  end
end
