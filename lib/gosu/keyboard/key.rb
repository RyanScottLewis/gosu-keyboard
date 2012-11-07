module Gosu
  class Keyboard
    class Key
      
      extend Forwardable
      def_delegators :@keyboard, :window
      
      def initialize(keyboard, name, handler=nil, &blk)
        @keyboard, @name, @blk = keyboard, name, blk
        @handler ||= @keyboard.handler
        
        @handler.call(&blk) if block_given?
      end
      
      def code
        Keyboard.keys[@name]
      end
      
      def &(key)
        Chain.new(@handler, :and, self, key)
      end
        
      def |(key)
        Chain.new(@handler, :or, self, key)
      end
      
    end
  end
end
