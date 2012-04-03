module Scorm2004
  module Manifest
    class Organization
      include VisitorPattern
      include Children
      include Attributes
      include XmlBase

      # @attribute [r] items
      # @return [Array<Item>] <item>
      has_one_or_more      'imscp:item'

      # @attribute [r] title
      # @return [Title] <title>
      has_one_and_only_one 'imscp:title'

      # @attribute [r] completion_threshold
      # @return [CompletionThreshold, nil] <adlcp:completionThrehsold>
      has_zero_or_one      'adlcp:completionThreshold'

      # @attribute [r] sequencing
      # @return [Sequencing, nil] <imsss:sequencing>
      has_zero_or_one      'imsss:sequencing'

      # @attribute [r] identifier
      # @return [String] The identifier attribute of <organization>
      attribute :id,      'identifier'

      # @attribute [r] objectives_global_to_system
      # @return [Boolean] The adlseq:objectivesGlobalToSystem attribute of <organization>
      attribute :boolean, 'adlseq:objectivesGlobalToSystem', default: false

      # @attribute [r] shared_data_global_to_system
      # @return [Boolean] The adlcp:sharedDataGlobalToSystem attribute of <organization>
      attribute :boolean, 'adlcp:sharedDataGlobalToSystem',  default: false
    end
  end
end
