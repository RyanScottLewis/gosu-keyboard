module Gosu
  class Keyboard
    class Key
      
      extend Forwardable
      def_delegators :@keyboard, :window
      
      def initialize(keyboard, name, handler=nil, &blk)
        @keyboard, @name = keyboard, name
        @handler ||= @keyboard.handler
        
        if block_given?
          p self
          @handler.children << self
          @handler.register(&blk)
        end
      end
      
      def code
        Keyboard.keys[@name]
      end
      
      def &(key)
        Condition.new(@handler, :and, self, key)
      end
        
      def |(key)
        Condition.new(@handler, :or, self, key)
      end
      
    end
  end
end
