require_relative '../../helper'

module Scorm2004
  module Manifest
    class ManifestTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = Manifest.new
        @v.stubs(:schema_visitor).returns(stub(:visit))
        @v.stubs(:schemaversion_visitor).returns(stub(:visit))
        @v.stubs(:resources_visitor).returns(stub(:visit))
        @v.stubs(:organizations_visitor).returns(stub(:visit))
        @v.stubs(:sequencing_collection_visitor).returns(stub(:visit))
      end

      context 'a manifest visitor' do
        should 'be able to handle xml:base' do
          assert @v.respond_to? :base
        end
      end

      context 'a manifest visitor visiting a valid manifest element' do
        should 'visit its offsprings and set attributes' do
          @v.expects(:schema_visitor).once.returns(mock(:visit))
          @v.expects(:schemaversion_visitor).once.returns(mock(:visit))
          @v.expects(:resources_visitor).once.returns(mock(:visit))
          @v.expects(:organizations_visitor).once.returns(mock(:visit))
          @v.expects(:sequencing_collection_visitor).once.returns(mock(:visit))
          el(<<-XML).accept(@v)
            <dummy identifier="sample" version="1.0" xml:base="path/to/root/">
              <metadata>
                <schema />
                <schemaversion />
              </metadata>
              <resources />
              <organizations />
              <imsss:sequencingCollection />
            </dummy>
          XML
          assert_equal "sample", @v.identifier
          assert_equal "1.0",    @v.version
          assert_equal Pathname('path/to/root'), @v.base
        end
      end

      context 'a manifest visitor visiting a manifest element without <schema>' do
        should 'raise exceptoin' do
          assert_error do
            el(<<-XML).accept @v
              <dummy identifier="sample" version="1.0">
                <metadata>
                  <schemaversion />
                </metadata>
                <resources />
                <organizations />
              </dummy>
            XML
          end
        end
      end
    
      context 'a manifest visitor visiting a manifest element without <schemaversion>' do
        should 'raise exceptoin' do
          assert_error do
            el(<<-XML).accept @v
              <dummy identifier="sample" version="1.0">
                <metadata>
                  <schema />
                </metadata>
                <resources />
                <organizations />
              </dummy>
            XML
          end
        end
      end

      context 'a manifest visitor visiting a manifest element without <resources>' do
        should 'raise exceptoin' do
          assert_error do
            el(<<-XML).accept @v
              <dummy identifier="sample" version="1.0">
                <metadata>
                  <schema />
                  <schemaversion />
                </metadata>
                <organizations />
              </dummy>
            XML
          end
        end
      end

      context 'a manifest visitor visiting a manifest element without <organizations>' do
        should 'raise exceptoin' do
          assert_error do
            el(<<-XML).accept @v
              <dummy identifier="sample" version="1.0">
                <metadata>
                  <schema />
                  <schemaversion />
                </metadata>
                <resources />
              </dummy>
            XML
          end
        end
      end

      context 'a manifest visitor visiting a manifest element without identifier' do
        should 'raise exeption' do
          assert_error do
            el(<<-XML).accept(@v)
              <dummy version="1.0">
                <metadata>
                  <schema />
                  <schemaversion />
                </metadata>
                <resources />
                <organizations />
              </dummy>
              XML
          end
        end
      end

      context 'a manifest visitor visiting a manifest element with version too long' do
        should 'raise exeption' do
          assert_error do
            el(<<-XML).accept(@v)
              <dummy identifier="dummy" version="01234567890123456789x">
                <metadata>
                  <schema />
                  <schemaversion />
                </metadata>
                <resources />
                <organizations />
              </dummy>
              XML
          end
        end
      end

      private

      def assert_error(&block)
        assert_raise Manifest::Error, &block
      end
    end
  end
end
