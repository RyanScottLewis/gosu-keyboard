require 'pathname'

__LIB__ ||= Pathname.new(__FILE__).join('..', '..', 'lib').expand_path
$:.unshift(__LIB__.to_s) unless $:.include?(__LIB__.to_s)

require 'gosu'
require 'gosu/keyboard'

module Simple
  module KeyboardHelpers
    def left
      super || a
    end
    
    def right
      super || d
    end
    
    def direction
      left || right
    end
    
    def walk
      direction && !shift && !control
    end
    
    def run
      direction && shift && !control
    end
    
    def crouch
      alt
    end
  end
end

Gosu::Keyboard.register(Simple::KeyboardHelpers)

module Simple
  class Player
    attr_accessor :state, :direction
    
    def initialize
      @state, @direction = :standing, :right
    end
  end
end

module Simple
  class GameWindow < Gosu::Window
    
    def initialize
      super(Gosu::screen_width, Gosu::screen_height, false)
        
      self.caption = "Gosu::Keyboard Test"
        
      @font = Gosu::Font.new(self, Gosu::default_font_name, 40)
      
      @player = Player.new
    end
      
    def update
      @player.state = :standing
      
      Gosu::Keyboard.handle_keys(self) do
        down?(escape) { close }
        down?(left)   { @player.direction = :left }
        down?(right)  { @player.direction = :right }
        down?(walk)   { @player.state = :walking }
        down?(run)    { @player.state = :running }
        down?(crouch) { @player.state = :crouching }
      end
    end
      
    def draw
      @font.draw "Player State: #{@player.state}", 0, 0, 0, 1, 1, Gosu::Color::BLUE
      @font.draw "Player Direction: #{@player.direction}", 0, 30, 0, 1, 1, Gosu::Color::BLUE
      @font.draw "Left, A - Change direction of player to 'left' and state to 'walk'", 0, 90, 0, 1, 1, Gosu::Color::RED
      @font.draw "Right, B - Change direction of player to 'right' and state to 'walk'", 0, 120, 0, 1, 1, Gosu::Color::RED
      @font.draw "Shift - Change state of player to 'running'", 0, 150, 0, 1, 1, Gosu::Color::RED
      @font.draw "Alt - Change state of player to 'crouching'", 0, 180, 0, 1, 1, Gosu::Color::RED
    end
    
    # Always show the system mouse cursor, for aesthetic reasons..
    def needs_cursor?
      true
    end
    
  end
end

window = Simple::GameWindow.new
window.show