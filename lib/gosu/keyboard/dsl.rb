module Gosu
  class Keyboard
    class DSL
      
      class << self
        
        def call(keyboard, &blk)
          new(keyboard, &blk)
        end
        
      end
      
      def initialize(keyboard, &blk)
        @keyboard = keyboard
        
        instance_eval(&blk)
      end
      
      def method_missing(key_name, &blk)
        super unless Keyboard.keys.has_key?(key_name)
        
        Key.new(@keyboard, key_name, &blk)
      end
      
    end
  end
end
