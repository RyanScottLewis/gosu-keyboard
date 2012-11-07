module Gosu
  class Keyboard
    class Handler
      
      extend Forwardable
      attr_reader :keyboard, :chains
      def_delegators :@keyboard, :window
      
      def initialize(keyboard)
        raise TypeError, 'keyboard must be an instance of Gosu::Keyboard' unless keyboard.instance_of?(Keyboard)
        
        @keyboard, @chains = keyboard, []
        @registry = {}
      end
      
      def <<(chain)
        @chains << chain
      end
      
      def register(&blk)
        @registry[@chains] = blk
        @chains = []
      end
      
      def handle_keys
        @registry.each do |chains, blk|
          
          puts "", ""
          p chains, blk
          puts "", ""
          
          chains.each do |chain|
            
          end
          
          break
          
          # Check if current Gosu keyboard events match the chains conditions
          # If so
          #   window.instance_eval(&blk)
          #   break enumerator
          
        end
      end
      
    end
  end
end
