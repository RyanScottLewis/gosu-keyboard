# Gosu-Keyboard

A DSL for easily handling keyboard events within a `Gosu::Window`.

## Install

### Bundler

Add the following to your `Gemfile`:

```ruby
gem 'gosu'
gem 'gosu-keyboard', require: 'gosu/keyboard'
```

### RubyGems

Install with:

```sh
$ gem install gosu-keyboard
```

and `require` with:

```ruby
require 'gosu/keyboard'
```

## Usage

### Sample usage within a `Gosu::Window`

`my_game/lib/keyboard_helpers.rb`

```ruby
module MyGame
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
  end
end

class Gosu::Keyboard::DSL
  include MyGame::KeyboardHelpers
end
```

`my_game/lib/player.rb`

```ruby
module MyGame
  class Player
    attr_accessor :state, :direction
    
    def initialize
      @state, @direction = :standing, :right
    end
  end
end
```

`my_game/lib/game_window.rb`

```ruby
module MyGame
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
        
        down?(left)               { @player.direction = :left }
        down?(right)              { @player.direction = :right }
        down?(direction)          { @player.state = :walking }
        down?(shift && direction) { @player.state = :running }
      end
    end
      
    def draw
      @font.draw "Player State: #{@player.state}", 0, 0, 0, 1, 1, Gosu::Color::BLUE
      @font.draw "Player State: #{@player.direction}", 0, 30, 0, 1, 1, Gosu::Color::BLUE
    end
    
    # Always show the system mouse cursor, for aesthetic reasons..
    def needs_cursor?
      true
    end
    
  end
end
```

`my_game/lib/my_game`

```ruby
require 'pathname'

require 'bundler/setup'
Bundler.require(:default)

require 'gosu'
require 'gosu/keyboard'

__LIB__ ||= Pathname.new(__FILE__).join('..', '..', 'lib').expand_path
$:.unshift(__LIB__.to_s) unless $:.include?(__LIB__.to_s)

require 'my_game/keyboard_helpers'
require 'my_game/player'
require 'my_game/game_window'
```

`my_game/bin/my_game`

```ruby
#!/usr/bin/env ruby

require 'pathname'

__LIB__ = Pathname.new(__FILE__).join('..', '..', 'lib').expand_path

$:.unshift(__LIB__.to_s) unless $:.include?(__LIB__.to_s)

require 'my_game'

window = MyGame::GameWindow.new
window.show
```

