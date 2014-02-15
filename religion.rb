#!/usr/bin/env ruby
#
# religion.rb
# SWN Religion Generator
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

# This class generates a religion from tables/religion.json, 
# which has the following attributes:
#
# evolution
# leadership
# origin_tradition
class Religion
  attr_reader :evolution, :leadership, :origin_tradition

  def initialize
    json = JSON.parse(File.read('tables/religion.json'))
    @evolution        = json['evolution'].sample
    @leadership       = json['leadership'].sample
    @origin_tradition = json['origin_tradition'].sample
  end

  def to_s
    <<-EOS.unindent
      Evolution: #{@evolution}
      Leadership: #{@leadership}
      Origin Tradition: #{@origin_tradition}
      EOS
  end
end


if __FILE__ == $0
  (ARGV.shift || 1).to_i.times do |e|
    puts '-----------+-+-+-----------' unless e == 0
    puts Religion.new
  end
end
