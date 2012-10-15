module Scorm2004
  module Manifest
    class Item
      include VisitorPattern
      include Children
      include Attributes
      
      # @attribute [r] identifier
      # @return [String] The +identifier+ attribute of <item>
      attribute :id,      'identifier'

      # @attribute [r] identifierref
      # @return [String] The +identifierref+ attribute of <item>
      attribute :string,  'identifierref', allow_nil: true

      # @attribute [r] isvisible
      # @return [Boolean] The +isvisible+ attribute of <item>
      attribute :boolean, 'isvisible',     default: true

      # @attribute [r] parameters
      # @return [String] The +parameters+ attribute of <item>
      attribute :string,  'parameters',    allow_nil: true

      # @attribute [r] title
      # @return [Title] <title>
      has_one_and_only_one 'imscp:title'

      # @attribute [r] item
      # @return [Array<Item>] <item>
      has_zero_or_more     'imscp:item'

      # @attribute [r] time_limit_action
      # @return [TimeLimitAction, nil] <adlcp:timeLimitAction>
      has_zero_or_one      'adlcp:timeLimitAction'

      # @attribute [r] data_from_lms
      # @return [DataFromLms, nil] <adlcp:dataFromLMS>
      has_zero_or_one      'adlcp:dataFromLMS'

      # @attribute [r] completion_threshold
      # @return [CompletionThreshold, nil] <adlcp:completionThreshold>
      has_zero_or_one      'adlcp:completionThreshold'

      # @attribute [r] sequencing
      # @return [Sequencing, nil] <imsss:sequencing>
      has_zero_or_one      'imsss:sequencing'

      # @attribute [r] presentation
      # @return [Presentation, nil] <adlnav:presentation>
      has_zero_or_one      'adlnav:presentation'

      # @attribute [r] data
      # @return [Data, nil] <adlcp:data>
      has_zero_or_one      'adlcp:data'
    end
  end
end
