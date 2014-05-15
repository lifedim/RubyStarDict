require 'ffi'

module LookupLib
  extend FFI::Library
  ffi_lib "clib/liblookup.so"
  attach_function :lookup, [:string, :long, :long, :string], :string
end
