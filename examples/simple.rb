require 'pathname'

__LIB__ = Pathname.new(__FILE__).join('..', '..', 'lib').expand_path
$:.unshift(__LIB__.to_s) unless $:.include?(__LIB__.to_s)

require 'gosu'
require 'gosu/keyboard'

class GameWindow < Gosu::Window
  
  def initialize
    super(Gosu::screen_width, Gosu::screen_height, false)
      
    self.caption = "Gosu::Keyboard Test"
      
    @font = Gosu::Font.new(self, Gosu::default_font_name, 40)
    @keyboard = Gosu::Keyboard.new(self) do
      escape { close }
      
      # left_shift & left | left_shift & a { @current_text = 'running left!' }
      # left_shift & right | left_shift & d { @current_text = 'running right!' }
      # left | a { @current_text = 'walking left!' }
      # right | d { @current_text = 'walking right!' }
      
      # default { @current_text = @default_text }
    end
    
    @current_text = @default_text = 'Press left, right, shift + left, shift + right, a, d, shift + a, or shift + d'
  end
    
  def update
    @keyboard.handle_keys
  end
    
  def draw
    @font.draw @current_text, 0, 0, 0, 1, 1, Gosu::Color::BLUE
  end
  
  # Always show the system mouse cursor, for aesthetic reasons..
  def needs_cursor?
    true
  end
  
end

window = GameWindow.new
window.show