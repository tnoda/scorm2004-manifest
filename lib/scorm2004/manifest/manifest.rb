module Scorm2004
  module Manifest
    class Manifest
      include VisitorPattern
      include CustomError
      include Children
      include Attributes
      include XmlBase
      
      has_one_and_only_one './imscp:metadata/imscp:schema'
      has_one_and_only_one './imscp:metadata/imscp:schemaversion'
      has_one_and_only_one 'imscp:resources'
      has_one_and_only_one 'imscp:organizations'
      has_zero_or_one      'imsss:sequencingCollection'

      attribute :id,     'identifier'
      attribute :string, 'version', spm: 20

      private
      
      def do_visit
        
      end
    end
  end
end
