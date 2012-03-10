require_relative '../../helper'

module Scorm2004
  module Manifest
    class RollupConsiderationsTest < ActiveSupport::TestCase
      include PartialManifest
      
      def self.token_attributes
        RollupConsiderations.attributes - [:measure_satisfaction_if_active]
      end

      setup do
        @v = RollupConsiderations.new
      end

      test 'default value of measureSatisfactionIfActive' do
        el.accept @v
        assert_equal true, @v.measure_satisfaction_if_active
      end

      token_attributes.each do |attr|
        test "default value of #{attr}" do
          el.accept @v
          assert_equal 'always', @v.send(attr)
        end
      end

      token_attributes.product(RollupConsiderations::CONDITIONS).each do |attr, condition|
        tag = "<dummy #{attr.to_s.camelize :lower}='#{condition}' />"
        test tag do
          el(tag).accept @v
          assert_equal condition, @v.send(attr)
        end
      end

      test 'false measureSatisfactionIfActive' do
        el('<dummy measureSatisfactionIfActive="0" />').accept @v
        assert_equal false, @v.measure_satisfaction_if_active
      end
    end
  end
end
