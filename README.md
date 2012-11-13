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

> Note: Real usage in `MyGame::GameWindow#update`.

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

Gosu::Keyboard.register(MyGame::KeyboardHelpers)
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
    
    # Always show the system mouse cursor, for aesthetic 
    # reasons. Has nothing to do with example.
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

## Contributing

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start or switch to a testing/unstable/feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, VERSION or gemspec.

## Copyright

Copyright © 2012 Ryan Scott Lewis <ryan@rynet.us>.

The MIT License (MIT) - See LICENSE for further details.
