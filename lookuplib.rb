require 'ffi'

module LookupLib
  extend FFI::Library
  ffi_lib "/Users/lifedim/Projects/scripts/rubydict/clib/liblookup.so"
  attach_function :lookup, [:string, :long, :long, :string], :string
end
