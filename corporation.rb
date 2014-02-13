#!/usr/bin/env ruby
#
# corporation.rb
# SWN Corporation Generator
#
# Copyright (C) 2014 Steve Simenic <orffen@orffenspace.com>
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

# This class generates an corporation from tables/corporation.json,
# which has the following attributes:
#
# name
# business
# reputation
class Corporation
  attr_reader :name, :business, :reputation

  def initialize
    json = JSON.parse(File.read('tables/corporation.json'))
    @name       = "#{json['name'].sample} #{json['organization'].sample}"
    @business   = json['business'].sample
    @reputation = json['reputation'].sample
  end

  def to_s
    <<-EOS.unindent
      Name: #{@name}
      Business: #{@business}
      Reputation: #{@reputation}
      EOS
  end
end


if __FILE__ == $0
  number = (ARGV.shift || 1).to_i
  (1..number).each do |e|
    puts Corporation.new
    if number > 1
      puts '-----------+-+-+-----------' unless e == number
    end
  end
end
