module Gosu
  module Keyboard
    class NoKeyError < NoMethodError; end
    
    class DSL
      
      def initialize(window, &blk)
        @window = window
        
        instance_eval(&blk)
      end
      
      def method_missing(key_name, &blk)
        raise NoKeyError unless Keyboard.keys.has_key?(key_name)
        
        @window.button_down?( Keyboard.keys[key_name] )
      end
      
      def down?(condition, &blk)
        @window.instance_eval(&blk) if condition
      end
      
    end
  end
end
