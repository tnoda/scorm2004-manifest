require_relative 'helper'
require_relative 'functional_test'

class SeceTest < ActiveSupport::TestCase
  include FunctionalTest

  gist 2020335, 'sece'

  test 'parsing imsmanifest.xml of ADL SCORM 2004 4th Edition SECE' do
    manifest = Scorm2004::Manifest(xml)

    # <manifest>
    assert_equal 'LMSTestPackage_T-01b', manifest.identifier
    assert_equal '1.0', manifest.version

    # <organizations>
    organizations = manifest.organizations
    assert_equal 'ORG-AAE040C6-5D31-FF80-7A74-C93346D3DE42', organizations.default

    # <organization>
    organization = organizations.organizations.first
    assert_equal 'ORG-AAE040C6-5D31-FF80-7A74-C93346D3DE42', organization.identifier
    assert_equal 'SCORM 2004 4th Edition Sequencing Essentials Content Example 1.0', organization.title.to_s

    # <controlMode>
    Scorm2004::Manifest::ControlMode.attributes.each do |attr|
      assert_equal (attr != :forward_only), organization.sequencing.control_mode.send(attr), attr.to_s
    end
    
    item_0 = organization.items[0]
    Scorm2004::Manifest::ControlMode.attributes.each do |attr|
      assert_equal (attr != :forward_only), item_0.sequencing.control_mode.send(attr), attr.to_s
    end

    last = organization.items.last
    Scorm2004::Manifest::ControlMode.attributes.each do |attr|
      assert_equal ![:flow, :forward_only].include?(attr), last.sequencing.control_mode.send(attr), attr.to_s
    end

    # <postConditionRule>
    rule = last.sequencing.sequencing_rules.post_condition_rules.first
    rule_conditions = rule.rule_conditions
    assert_equal 'all', rule_conditions.condition_combination
    rule_condition = rule_conditions.rule_conditions.first
    assert_equal 'noOp', rule_condition.operator
    assert_equal 'attempted', rule_condition.condition
    rule_action = rule.rule_action
    assert_equal 'exitAll', rule_action.action

    # <rollupRules>
    assert_equal 1.0, last.sequencing.rollup_rules.objective_measure_weight
  end
end
