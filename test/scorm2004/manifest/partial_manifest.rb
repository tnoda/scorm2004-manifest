require 'nokogiri'

module PartialManifest
  def el(fragment = '<dummy />')
    Nokogiri::XML(<<XML).root.at('./*', Scorm2004::Manifest::NS)
<?xml version = "1.0" standalone = "no"?>
<manifest identifier = "minimal_manifest" version = "1.0"
    xmlns = "http://www.imsglobal.org/xsd/imscp_v1p1"
    xmlns:adlcp = "http://www.adlnet.org/xsd/adlcp_v1p3"
    xmlns:adlseq = "http://www.adlnet.org/xsd/adlseq_v1p3"
    xmlns:adlnav = "http://www.adlnet.org/xsd/adlnav_v1p3"
    xmlns:imsss = "http://www.imsglobal.org/xsd/imsss"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation = "http://www.imsglobal.org/xsd/imscp_v1p1 imscp_v1p1.xsd
        http://www.adlnet.org/xsd/adlcp_v1p3 adlcp_v1p3.xsd
        http://www.adlnet.org/xsd/adlseq_v1p3 adlseq_v1p3.xsd
        http://www.adlnet.org/xsd/adlnav_v1p3 adlnav_v1p3.xsd
        http://www.imsglobal.org/xsd/imsss imsss_v1p0.xsd">
#{fragment}
</manifest>
XML
  end
end
