module Scorm2004
  module Manifest
    module CustomError
      def self.included(base)
        base.class_eval do
          const_set('Error', Class.new(Scorm2004::Manifest::Error))
        end
      end
      
      def error(message)
        raise("#{self.class}::Error".constantize, message)
      end
    end
  end
end

