require_relative '../../helper'

module Scorm2004
  module Manifest
    class AnyUriTokenTest < ActiveSupport::TestCase
      include PartialManifest
      
      class Visitor
        include VisitorPattern
        include CustomError
        include Attributes

        attribute :any_uri, 'foo'
      end

      setup do
        @v = Visitor.new
      end

      valid_uris = [
        ' http://example.com/a ',
        ' path/to/somewhere '
      ]

      valid_uris.each do |valid_uri|
        tag = "<dummy foo='#{valid_uri}' />"
        test tag do
          el(tag).accept(@v)
          assert_equal URI(valid_uri).to_s, @v.foo
        end
      end

      test 'invalid uri causes error' do
        assert_raise Visitor::Error do
          el('<dummy foo=" a b c " />').accept(@v)
        end
      end
    end
  end
end
