module MettleMe
  module RSpec
    module Matchers
      def act_as_taggable_on(tags_name)
        ActsAsTaggableOn.new(tags_name)
      end
      
      class ActsAsTaggableOn
        attr :actual
        attr :tags_name
        
        def initialize(tags_name)
          @tags_name = tags_name
        end
        
        def failure_message
          "expected #{actual} to #{failures}"
        end
        
        def matches?(actual)
          @actual = actual
          method_match? && class_match?
        end
        
        private        
        def class_match?
          @class_match ||= actual.send(tags_name).class == Array
        end
        
        def method_match?
          @method_match ||= actual.respond_to?(tags_name)  
        end        
        
        def failures(result = [])
          result << "respond to :#{tags_name}" if method_match?
          result << "have :#{tags_name} as an Array" if class_match?
          result.join(' and ')
        end
      end
    end
  end
end