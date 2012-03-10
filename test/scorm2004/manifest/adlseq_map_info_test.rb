require_relative '../../helper'

module Scorm2004
  module Manifest
    class AdlseqMapInfoTest < ActiveSupport::TestCase
      include PartialManifest
      
      class << self
        def flags
          AdlseqMapInfo.attributes - [:target_objective_id]
        end

        def default(attr)
          /^read/ =~ attr ? true : false
        end
      end

      setup do
        @v = AdlseqMapInfo.new
      end
      
      test 'an empty element causes error' do
        assert_raise(AdlseqMapInfo::Error) { el.accept @v }
      end

      flags.each do |attr|
        test "default value of #{attr.to_s.camelize :lower}" do
          el('<dummy targetObjectiveID="foo" />').accept @v
          assert_equal default(attr), @v.send(attr)
        end
      end

      flags.each do |attr|
        test "#{attr.to_s.camelize :lower} = #{!default(attr)}" do
          el("<dummy targetObjectiveID='bar' #{attr.to_s.camelize :lower}='#{!default(attr)}' />")
        end
      end

      private


      def default(attr)
        self.class.default attr
      end
    end
  end
end
