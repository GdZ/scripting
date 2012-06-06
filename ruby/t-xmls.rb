#!/usr/bin/ruby
require 'rubygems'
require "rubyXL"
require 'pp'
workbook = RubyXL::Parser.parse("PC-Mac test cases-20120412.xlsx")

puts "worksheets number: " + workbook.worksheets.length.to_s
workbook.worksheets.each do |ws|
  #pp ws
end

ws0 = workbook.worksheets[0]
data = ws0.extract_data
pp data
row1 = ws0.sheet_data[0]
row2 = ws0.sheet_data[1]
#pp row2
pp ws0.get_row_fill(1)

