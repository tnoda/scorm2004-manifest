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

      # @attribute [r] resources
      # @return [Resources] <resources>
      has_one_and_only_one 'imscp:resources'

      # @attribute [r] organizations
      # @return [Organizations] <organizations>
      has_one_and_only_one 'imscp:organizations'

      # @attribute [r] sequencing_collection
      # @return [SequencingCollection, nil] <imsss:sequencingCollection>
      has_zero_or_one      'imsss:sequencingCollection'

      # @attribute [r] identifier
      # @return [String] The identifier attribute of <manifest>
      attribute :id,     'identifier'

      # @attribute [r] version
      # @return [String] The version attribute of <manifest>
      attribute :string, 'version', spm: VERSION_SPM
    end
  end
end
