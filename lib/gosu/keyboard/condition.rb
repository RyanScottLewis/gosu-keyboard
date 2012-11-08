module Gosu
  class Keyboard
    
    class Condition
      VALID_TYPES = [:and, :or]
      
      attr_reader :type, :children
      
      def initialize(handler, type, *children)
        raise TypeError, "type must be one of the following: #{VALID_TYPES.join(', ')}" unless VALID_TYPES.include?(type)
        raise TypeError, 'handler must be an instance of Gosu::Handler' unless handler.instance_of?(Handler)
        
        @handler, @type, @children = handler, type, children
        @handler.children << self
      end
      
      def <<(key)
        @children << key
        
        self
      end
      
      def &(key)
        @children << @type == :and ? key : Condition.new(@handler, :and, key)
      end
      
      def |(key)
        @children << @type == :or ? key : Condition.new(@handler, :or, key)
      end
    end
    
  end
end
