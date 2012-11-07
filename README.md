# Gosu-Keyboard

A DSL for easily handling keyboard events within a `Gosu::Window`.

## Install

> Note:  This is unfinished. Wait until the gem is out to install with the following methods.

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

`my_game/lib/game_window.rb`

```ruby
require 'bundler/setup'
Bundler.require(:default)

class GameWindow < Gosu::Window
  
  def initialize
    super(Gosu::screen_width, Gosu::screen_height, false)
    
    self.caption = "My Game"
    
    @font = Gosu::Font.new(self, Gosu::default_font_name, 40)
    
    @text = {
      default: 'Press left, right, shift + left, shift + right, a, d, shift + a, or shift + d',
      walking_left: 'Walking left!',
      walking_right: 'Walking right!',
      running_left: 'Running left!',
      running_right: 'Running right!',
    }
    
    @keyboard = Gosu::Keyboard.new(self) do
      default { use_text(:default) } # When no keys are being pressed
      escape { close }
      
      left_shift & left | left_shift & a { use_text(:running_left) }
      left_shift & right | left_shift & d { use_text(:running_right) }
      left | a { use_text(:walking_left) }
      right | d { use_text(:walking_right) }
    end
  end
    
  def update
    @keyboard.handle_keys
  end
    
  def draw
    @font.draw(@current_text, 0, 0, 0, 1, 1, Gosu::Color::BLUE)
  end
  
  # Always show the system mouse cursor, for aesthetic reasons..
  def needs_cursor?
    true
  end
  
  def use_text(key)
    @current_text = @text[key] unless @current_text == @text[key]
  end
  
end
```

`my_game/bin/my_game`

```ruby
#!/usr/bin/env ruby

require 'pathname'

__LIB__ = Pathname.new(__FILE__).join('..', '..', 'lib').expand_path

$:.unshift(__LIB__.to_s) unless $:.include?(__LIB__.to_s)

require 'my_game'

window = GameWindow.new
window.show
```

