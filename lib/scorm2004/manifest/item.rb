module Scorm2004
  module Manifest
    class Item
      include VisitorPattern
      include CustomError
      include Children
      include Attributes
      
      attribute :id,      'identifier'
      attribute :string,  'identifierref', allow_nil: true
      attribute :boolean, 'isvisible',     default: true
      attribute :string,  'parameters',    allow_nil: true

      has_one_and_only_one 'imscp:title'
      has_one_or_more      'imscp:item'
      has_zero_or_one      'adlcp:timeLimitAction'
      has_zero_or_one      'adlcp:dataFromLMS'
      has_zero_or_one      'adlcp:completionThreshold'
      has_zero_or_one      'imsss:sequencing'
      has_zero_or_one      'adlnav:presentation'
      has_zero_or_one      'adlcp:data'

      private
      
      def do_visit
        if identifierref && resource.nil?
          error("A <resource> element whose identifier is #{identifierref} not found:")
        end
      end

      def resource
        el.at("/imscp:manifest/imscp:resources/imscp:resource[@identifier='#{identifierref}']", NS)
      end
    end
  end
end
