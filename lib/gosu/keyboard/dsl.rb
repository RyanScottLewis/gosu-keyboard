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
      
      # def shift
      #   left_shift | right_shift
      # end
      
      # def alt
      #   left_alt | right_alt
      # end
      
      # def control
      #   left_control | right_control
      # end
      
      def nothing(&blk)
        @nothing = blk
      end
      
      def method_missing(key_name, &blk)
        super unless Keyboard.keys.has_key?(key_name)
        
        Key.new(@keyboard, key_name, &blk)
      end
      
    end
  end
end
