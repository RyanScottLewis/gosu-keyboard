module Gosu
  class Keyboard
    class DSL
      
      module Helpers
        
        def shift
          left_shift | right_shift
        end
        
        def alt
          left_alt | right_alt
        end
        
        def control
          left_control | right_control
        end
        
        def default(&blk)
          @default = blk
        end
        
      end
      
      include Helpers
      
    end
  end
end
