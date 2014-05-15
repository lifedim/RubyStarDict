require 'ffi'

module MixBox

  module Dictionary
    extend FFI::Library
    ffi_lib "clib/liblookup.so"
    attach_function :lookup, [:string, :long, :long, :string], :string
  end

  class Translator
    def self.file_info dict_path
      file_size, word_count = 0, 0

      @file ||= File.open("#{dict_path}.ifo")
      @file.each do |line|
        keyvalue = line.strip.split('=')
        word_count = keyvalue[1].to_i if keyvalue[0] == 'wordcount'
        file_size = keyvalue[1].to_i if keyvalue[0] == 'idxfilesize'
      end

      [file_size, word_count]
    end

    def self.lookup word, dict="21shijishuangxiangcidian"

      dict_path ||= "./dict/#{dict}/#{dict}"
      file_size, word_count = file_info(dict_path)

      Dictionary.lookup dict_path, file_size, word_count, word
    end
  end
end

puts MixBox::Translator.lookup 'damn'
