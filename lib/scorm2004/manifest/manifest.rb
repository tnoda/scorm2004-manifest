module Scorm2004
  module Manifest
    class Manifest
      include VisitorPattern
      include Children
      include Attributes
      include XmlBase
      
      VERSION_SPM = 20

      has_one_and_only_one './imscp:metadata/imscp:schema'
      has_one_and_only_one './imscp:metadata/imscp:schemaversion'
      has_one_and_only_one 'imscp:resources'
      has_one_and_only_one 'imscp:organizations'
      has_zero_or_one      'imsss:sequencingCollection'

      attribute :id,     'identifier'
      attribute :string, 'version', spm: VERSION_SPM
    end
  end
end
