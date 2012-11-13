require 'forwardable'
require 'pathname'

require 'bundler/setup'
require 'active_support/core_ext/string/inflections'
require 'active_support/hash_with_indifferent_access'
require 'gosu'

__LIB__ = Pathname.new(__FILE__).join('..', '..').expand_path
$:.unshift(__LIB__.to_s) unless $:.include?(__LIB__.to_s)

require 'gosu/keyboard/dsl'
require 'gosu/keyboard/dsl/helpers'

module Gosu
  module Keyboard
    
    class << self
      
      def keys
        @keys ||= Gosu.constants.collect(&:to_s).grep(/^Kb/).each_with_object({}) do |constant_name, memo|
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
      end
      
      def handle_keys(window, &blk)
        DSL.new(window, &blk)
      end
      
    end
    
  end
end
