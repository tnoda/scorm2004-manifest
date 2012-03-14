require_relative 'helper'
require_relative 'functional_test'

class MsceTest < ActiveSupport::TestCase
  include FunctionalTest

  gist 2034296, 'msce'

  test 'parsing imsmanifest.xml of ADL SCORM 2004 4th Edition MSCE' do
    manifest = Scorm2004::Manifest(xml)

    # <manifest>
    assert_equal 'LMSTestPackage_RU-12b', manifest.identifier

    # <organizations>
    organizations = manifest.organizations
    assert_equal 'org1', organizations.default

    # <organization>
    organization = organizations.organizations.first
    assert_equal 'org1', organization.identifier

    # <item>
    pretest = organization.items.find { |item| item.identifier == 'pretest' }
    assert_equal 'Pre-Assessment', pretest.title.to_s

    # <sequencingRules>
    rule = pretest.sequencing.sequencing_rules.pre_condition_rules.first
    assert_equal 'attempted', rule.rule_conditions.rule_conditions.first.condition
    assert_equal 'skip', rule.rule_action.action

    # <objectives>
    assert_equal false, pretest.sequencing.rollup_rules.rollup_objective_satisfied
    assert_equal 'PRIMARYOBJ', pretest.sequencing.objectives.primary_objective.objective_id
    objectives = pretest.sequencing.objectives.objectives
    obj1 = objectives[0]
    assert_equal 'obj_module_1', obj1.objective_id
    map_info = obj1.map_infos[0]
    assert_equal 'obj_module_1', map_info.target_objective_id
    assert_equal false, map_info.read_satisfied_status
    assert_equal false, map_info.read_normalized_measure
    assert_equal true,  map_info.write_satisfied_status
    assert_equal true,  map_info.write_normalized_measure

    # assessment activity
    assessment = organization.items.find { |item| item.identifier == 'assessment' }
    module1 = assessment.items.find { |item| item.identifier == 'assess-module1' }
    sequencing = module1.sequencing
    rollup_rule = sequencing.rollup_rules.rollup_rules[0]
    condition = rollup_rule.rollup_conditions.rollup_conditions[0]
    assert_equal 'attempted', condition.condition
    assert_equal 'completed', rollup_rule.rollup_action.action
    assert_equal 'ifNotSkipped', sequencing.rollup_considerations.required_for_completed
  end
end
