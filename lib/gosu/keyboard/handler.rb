module Gosu
  class Keyboard
    class Handler
      
      extend Forwardable
      attr_reader :keyboard, :children
      def_delegators :@keyboard, :window
      
      def initialize(keyboard)
        raise TypeError, 'keyboard must be an instance of Gosu::Keyboard' unless keyboard.instance_of?(Keyboard)
        
        @keyboard, @children = keyboard, []
        @registry = {}
      end
      
      def <<(child)
        @children << child
      end
      
      def register(&blk)
        @registry[@children] = blk
        @children = []
      end
      
      def handle_keys
        @registry.each do |children, blk|
          
          puts "", ""
          p children, blk
          puts "", ""
          
          # children.each do |child|
          #   
          # end
          
          exit
          # Check if current Gosu keyboard events match the children conditions
          # If so
          #   window.instance_eval(&blk)
          #   break enumerator
          
        end
      end
      
    end
  end
end
