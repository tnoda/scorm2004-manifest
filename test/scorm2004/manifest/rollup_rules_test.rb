require_relative '../../helper'

module Scorm2004
  module Manifest
    class RollupRulesTest < ActiveSupport::TestCase
      include PartialManifest
      
      setup do
        @v = RollupRules.new
        [ :rollup_rule_visitor,
          :rollup_conditions_visitor,
          :rollup_action_visitor
        ].each do |child_visitor|
          @v.stubs(child_visitor).returns(stub(:visit))
        end
      end

      test 'an empty element causes error' do
        assert_error { el.accept(@v) }
      end

      test 'a visitor sets default values as its attribute' do
        el('<dummy><imsss:rollupConditions /><imsss:rollupAction /></dummy>').accept(@v)
        assert_equal true, @v.rollup_objective_satisfied
        assert_equal true, @v.rollup_progress_completion
        assert_equal 1.0,  @v.objective_measure_weight
      end

      test 'a fully-equipped element' do
        [ :rollup_conditions_visitor, :rollup_action_visitor ].each do |singular_child|
          @v.expects(singular_child).once.returns(mock(:visit))
        end
        rollup_rule_visitor = mock()
        rollup_rule_visitor.expects(:visit).twice
        @v.expects(:rollup_rule_visitor).twice.returns(rollup_rule_visitor)
        el(<<-XML).accept(@v)
          <dummy>
            <imsss:rollupRule />
            <imsss:rollupRule />
            <imsss:rollupConditions />
            <imsss:rollupAction />
          </dummy>
        XML
      end

      [0.0, 0.5, 1.0].each do |valid_objective_measure_weight|
        tag = <<-XML
          <dummy objectiveMeasureWeight="#{valid_objective_measure_weight}">
            <imsss:rollupConditions />
            <imsss:rollupAction />
          </dummy>
        XML
        test tag do
          el(tag).accept(@v)
          assert_equal valid_objective_measure_weight, @v.objective_measure_weight
        end
      end

      [-0.0001, 1.0001].each do |invalid_objective_measure_weight|
        tag = <<-XML
          <dummy objectiveMeasureWeight="#{invalid_objective_measure_weight}">
            <imsss:rollupConditions />
            <imsss:rollupAction />
          </dummy>
        XML
        test tag do
          assert_error { el(tag).accept(@v) }
        end
      end

      def assert_error &block
        assert_raise RollupRules::Error, &block
      end
    end
  end
end
