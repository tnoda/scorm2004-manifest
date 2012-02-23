require 'active_support/core_ext'
require 'scorm2004/manifest/visitor_pattern'
require 'scorm2004/manifest/custom_error'
require 'scorm2004/manifest/attributes'

module Scorm2004
  module Manifest
    class Error < StandardError; end

    NS = {
      'imscp'  => "http://www.imsglobal.org/xsd/imscp_v1p1",
      'adlcp'  => "http://www.adlnet.org/xsd/adlcp_v1p3",
      'adlseq' => "http://www.adlnet.org/xsd/adlseq_v1p3",
      'adlnav' => "http://www.adlnet.org/xsd/adlnav_v1p3",
      'imsss'  => "http://www.imsglobal.org/xsd/imsss"
    }
  end
end
