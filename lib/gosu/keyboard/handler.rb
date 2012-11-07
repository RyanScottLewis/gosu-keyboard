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
        # TODO: Lots of logic here... iterator over the handlers chains to determine conditions are being met
        # and if sooooo then just:
        
        # window.instance_eval(&blk)
      end
      
    end
  end
end
