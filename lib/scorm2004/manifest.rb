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

