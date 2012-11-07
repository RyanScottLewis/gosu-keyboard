require 'forwardable'
require 'pathname'

require 'bundler/setup'
require 'active_support/core_ext/string/inflections'
require 'active_support/hash_with_indifferent_access'
require 'gosu'

__LIB__ = Pathname.new(__FILE__).dirname.expand_path
$:.unshift(__LIB__.to_s) unless $:.include?(__LIB__.to_s)

require 'gosu/keyboard/dsl'
require 'gosu/keyboard/dsl/helpers'
require 'gosu/keyboard/key'
require 'gosu/keyboard/chain'
require 'gosu/keyboard/handler'
require 'gosu/keyboard'
