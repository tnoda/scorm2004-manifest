module Scorm2004
  module Manifest
    class RuleAction
      include VisitorPattern
      include Attributes
      
      PRE  = %w( skip disabled hiddenFromChoice stopForwardTraversal )
      POST = %w( exitParent exitAll retry retryAll continue previous )
      EXIT = %w( exit )

      attribute :token, 'action', vocabulary: PRE + POST + EXIT

      private
      
      def do_visit
        parent_name = @el.at('..').name
        case parent_name
        when 'preConditionRule'
          error("Invalid rule action in <preConditionRule>: #{action}") unless PRE.include?(action)
        when 'postConditionRule'
          error("Invalid rule action in <postConditionRule>: #{action}") unless POST.include?(action)
        when 'exitConditionRule'
          error("Invalid rule action in <exitConditionRuel>: #{action}") unless EXIT.include?(action)
        else
          error("Invalid parent element for <ruleAction>: <#{parent_name}>")
        end
      end
    end
  end
end
