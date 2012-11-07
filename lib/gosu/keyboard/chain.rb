module Gosu
  class Keyboard
    
    class Chain
      VALID_TYPES = [:and, :or]
      
      attr_reader :children
      
      def initialize(handler, type, *children)
        raise TypeError, "type must be one of the following: #{VALID_TYPES.join(', ')}" unless VALID_TYPES.include?(type)
        raise TypeError, 'handler must be an instance of Gosu::Keyboard::Handler' unless handler.instance_of?(Handler)
        
        @handler, @type, @children = handler, type, children
        @handler.chains << self
      end
      
      def <<(key)
        @children << key
        
        self
      end
      
      def &(key)
        @children << key
      end
      
      def |(key)
        @children << Chain.new(@handler, :or, key)
      end
    end
    
  end
end
