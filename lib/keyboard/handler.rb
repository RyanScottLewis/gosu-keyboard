module Gosu
  class Keyboard
    class Handler
      
      extend Forwardable
      attr_reader :keyboard, :chains
      def_delegators :@keyboard, :window
      
      def initialize(keyboard)
        @keyboard, @chains = keyboard, []
      end
      
      def <<(chain)
        @chains << chain
      end
      
      def call(&blk)
        
      end
      
    end
  end
end
