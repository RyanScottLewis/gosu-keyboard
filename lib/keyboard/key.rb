module Gosu
  class Keyboard
    class Key
      
      NAMES = Gosu.constants.collect(&:to_s).grep(/^Kb/).each_with_object({}) do |constant_name, memo|
        constant = Gosu.const_get(constant_name)
        key_name = constant_name.gsub(/^Kb/, '').underscore.gsub(/numpad(\d)/, 'numpad_\1')
        
        key_name = case key_name
          when '0' then :zero
          when '1' then :one
          when '2' then :two
          when '3' then :three
          when '4' then :four
          when '5' then :five
          when '6' then :six
          when '7' then :seven
          when '8' then :eight
          when '9' then :nine
          else
            key_name.to_sym
        end
        
        memo[key_name] = constant
      end
      
      extend Forwardable
      def_delegators :@keyboard, :window
      
      def initialize(keyboard, name, handler=nil, &blk)
        @keyboard, @name, @blk = keyboard, name, blk
        @handler ||= @keyboard.handler
        
        @handler.call(&blk) if block_given?
      end
      
      def code
        NAMES[@name]
      end
      
      def &(key)
        Chain.new(@handler, :and, self, key)
      end
        
      def |(key)
        Chain.new(@handler, :or, self, key)
      end
      
    end
  end
end
