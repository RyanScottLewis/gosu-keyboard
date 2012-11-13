module Gosu
  module Keyboard
    class DSL
      
      module Helpers
        
        def shift
          left_shift || right_shift
        end
        
        def alt
          left_alt || right_alt
        end
        
        def control
          left_control || right_control
        end
        
      end
      
      include Helpers
      
    end
  end
end
