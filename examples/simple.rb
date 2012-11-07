
class GameWindow < Gosu::Window
  def initialize
    super(Gosu::screen_width, Gosu::screen_height, false)
      
    self.caption = "Gosu::Keyboard Test"
      
    @font = Gosu::Font.new(self, Gosu::default_font_name, 40)
    @keyboard = Gosu::Keyboard.new(self)
    
    @current_text = nil
  end
    
  def update
    handle_keys
    calculate_delta
  end
    
  def draw
    @font.draw @current_text, 0, 0, 0, 1, 1, Gosu::Color::BLUE
  end
    
  protected
    
  def handle_keys
    @keyboard.handle_keys do
      
      escape { close }
      
      left_shift & left | left_shift & a { @current_text = 'running left!' }
      left_shift & right | left_shift & d { @current_text = 'running right!' }
      left | a { @current_text = 'walking left!' }
      right | d { @current_text = 'walking right!' }
      
      nothing { @current_text = 'Press left, right, shift + left, shift + right, a, d, shift + a, or shift + d' }
    end
  end
end
