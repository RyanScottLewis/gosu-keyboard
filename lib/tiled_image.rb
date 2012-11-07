module Gosu
  
  class TiledImage < Image
    
    def draw(canvas_width, canvas_height, factor_x = 1, factor_y = 1, color = 0xffffffff, mode = :default)
      (canvas_width.to_f / self.width.to_f).ceil.times do |x|
        x = x * self.width
        (canvas_height.to_f / self.height.to_f).ceil.times do |y|
          y = y * self.height
          
          super(x, y, 0, factor_x, factor_y, color, mode)
        end
      end
    end
    
  end
  
end