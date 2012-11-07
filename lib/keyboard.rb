module Gosu
  class Keyboard
    
    class << self
      def handle_keys(window=nil, &blk)
        new(window).handle_keys(&blk)
      end
    end
    
    attr_reader :handler
    
    def initialize(window=nil)
      @window, @handler = window, Handler.new(self)
    end
    
    def handle_keys(&blk)
      DSL.call(self, &blk)
    end
    
  end
end
