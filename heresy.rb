#!/usr/bin/env ruby
#
# heresy.rb
# SWN Heresy Generator
#
# Copyright (c) 2014 Steve Simenic <orffen@orffenspace.com>
#
# This file is part of the SWN Toolbox.
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
#

require 'json'
require './unindent'

# This class generates an heresy from tables/heresy.json, 
# which has the following attributes:
#
# - founder (string)
# - major_heresy (string)
# - attitude (string)
# - quirk (string)
#
class Heresy
  attr_reader :founder, :major_heresy, :attitude, :quirk

  def initialize
    json = JSON.parse(File.read('tables/heresy.json'))
    @founder      = json['founder'].sample.to_str
    @major_heresy = json['major_heresy'].sample.to_str
    @attitude     = json['attitude'].sample.to_str
    @quirk        = json['quirk'].sample.to_str
  end

  def to_s
    <<-EOS.unindent
      |Founder: #{@founder}
      |Major Heresy: #{@major_heresy}
      |Attitude: #{@attitude}
      |Quirk: #{@quirk}
      EOS
  end
end


if __FILE__ == $0
  Integer(ARGV.shift || 1).times do |e|
    puts '-----------+-+-+-----------' unless e.zero?
    puts Heresy.new
  end
end
