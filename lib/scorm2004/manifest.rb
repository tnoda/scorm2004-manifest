require 'active_support/core_ext'
require 'scorm2004/manifest/visitor_pattern'
require 'scorm2004/manifest/custom_error'
require 'scorm2004/manifest/attributes'
require 'scorm2004/manifest/children'
require 'scorm2004/manifest/xml_base'
require 'scorm2004/manifest/error'
require 'scorm2004/manifest/text_node'
require 'scorm2004/manifest/manifest'
require 'scorm2004/manifest/schema'
require 'scorm2004/manifest/schemaversion'
require 'scorm2004/manifest/resources'
require 'scorm2004/manifest/href'
require 'scorm2004/manifest/resource'
require 'scorm2004/manifest/file'
require 'scorm2004/manifest/dependency'
require 'scorm2004/manifest/organizations'
require 'scorm2004/manifest/organization'
require 'scorm2004/manifest/title'
require 'scorm2004/manifest/completion_threshold'
require 'scorm2004/manifest/item'
require 'scorm2004/manifest/time_limit_action'
require 'scorm2004/manifest/data_from_lms'
require 'scorm2004/manifest/presentation'
require 'scorm2004/manifest/navigation_interface'
require 'scorm2004/manifest/hide_lmsui'
require 'scorm2004/manifest/data.rb'
require 'scorm2004/manifest/map.rb'
require 'scorm2004/manifest/sequencing_collection'
require 'scorm2004/manifest/sequencing'
require 'scorm2004/manifest/control_mode'
require 'scorm2004/manifest/sequencing_rules'
require 'scorm2004/manifest/condition_rule'
require 'scorm2004/manifest/rule_conditions'
require 'scorm2004/manifest/rule_action'
require 'scorm2004/manifest/rule_condition'
require 'scorm2004/manifest/limit_conditions'
require 'scorm2004/manifest/rollup_rules'
require 'scorm2004/manifest/rollup_conditions'
require 'scorm2004/manifest/rollup_condition'
require 'scorm2004/manifest/rollup_action'
require 'scorm2004/manifest/objectives'
require 'scorm2004/manifest/primary_objective'
require 'scorm2004/manifest/min_normalized_measure'
require 'scorm2004/manifest/map_info'
require 'scorm2004/manifest/objective'
require 'scorm2004/manifest/randomization_controls'
require 'scorm2004/manifest/delivery_controls'
require 'scorm2004/manifest/constrained_choice_considerations'
require 'scorm2004/manifest/rollup_considerations'
require 'scorm2004/manifest/adlseq_objectives'
require 'scorm2004/manifest/adlseq_objective'

module Scorm2004
  module Manifest
    NS = {
      'imscp'  => "http://www.imsglobal.org/xsd/imscp_v1p1",
      'adlcp'  => "http://www.adlnet.org/xsd/adlcp_v1p3",
      'adlseq' => "http://www.adlnet.org/xsd/adlseq_v1p3",
      'adlnav' => "http://www.adlnet.org/xsd/adlnav_v1p3",
      'imsss'  => "http://www.imsglobal.org/xsd/imsss"
    }
  end
end

