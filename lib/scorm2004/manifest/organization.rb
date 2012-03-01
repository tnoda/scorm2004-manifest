module Scorm2004
  module Manifest
    class Organization
      include VisitorPattern
      include CustomError
      include Children
      include Attributes
      include XmlBase

      has_one_or_more      'imscp:item'
      has_one_and_only_one 'imscp:title'
      has_zero_or_one      'adlcp:completionThreshold'
      has_zero_or_one      'imsss:sequencing'

      attribute :id,      'identifier'
      attribute :boolean, 'adlseq:objectivesGlobalToSystem', default: false
      attribute :boolean, 'adlcp:sharedDataGlobalToSystem',  default: false
    end
  end
end
