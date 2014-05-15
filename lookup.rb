# -*- coding: utf-8 -*-
#!/usr/bin/ruby

require 'ffi'
require './lookuplib'

if ARGV.length<1 then
    puts "USAGE: lookup [-l/--list] [<dictinoary name>] <word>"
    exit
end

dict_path_base = './dict'
if ARGV[0]=='-l' or ARGV[0]=='--list' then
  dict_list_file = File.open("#{dict_path_base}/list.txt")
  puts dict_list_file.read
  dict_list_file.close
  exit
end

#read dict list
dict_list_file = File.open("#{dict_path_base}/list.txt")
dict_list = dict_list_file.read.strip.split("\n")
dict_list_file.close

#march dictionary name
dict_name = dict_list[0]
word = ARGV[0]

if ARGV.length >= 2 then
  if dict_list.include?(ARGV[0]) then
    dict_name = ARGV[0]
  end
  word = ARGV[1]
end

file_size = 0
word_count = 0
dict_path = "#{dict_path_base}/#{dict_name}/#{dict_name}"

#read ifo file
ifo = File.open("#{dict_path}.ifo")
ifo.each do |line|
  keyvalue = line.strip.split('=')
  word_count = keyvalue[1].to_i if keyvalue[0] == 'wordcount'
  file_size = keyvalue[1].to_i if keyvalue[0] == 'idxfilesize'
end

#puts "Used dictionary: #{dict_name}\n"
if file_size and word_count and word then
  defination = LookupLib.lookup(dict_path, file_size, word_count, word)
  puts defination
else
  puts "Incorrect dictionary\n"
end
