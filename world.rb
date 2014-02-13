#!/usr/bin/env ruby
#
# world.rb
# SWN World Generator
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

# This class generates a world from tables/world.json, 
# which has the following attributes:
#
# atmosphere
# temperature
# biosphere
# population
# tech_level
# tags
#
class World
  attr_reader :atmosphere, :temperature, :biosphere, :population,
    :tech_level, :tags

  def initialize
    json = JSON.parse(File.read('tables/world.json'))
    @atmosphere  = json['atmosphere'].sample
    @temperature = json['temperature'].sample
    @biosphere   = json['biosphere'].sample
    @population  = json['population'].sample
    @tech_level  = json['tech_level'].sample
    @tags = []
    while tags.length < 2
      tags.push json['tags'].sample
    end
  end

  def to_s
    <<-EOS.unindent
      Atmosphere: #{@atmosphere}
      Temperature: #{@temperature}
      Biosphere: #{@biosphere}
      Population: #{@population}
      Tech Level: #{@tech_level}
      Tags: #{@tags.join(', ')}
      EOS
  end
end


if __FILE__ == $0
  number = (ARGV.shift || 1).to_i
  (1..number).each do |e|
    puts World.new
    if number > 1
      puts '-----------+-+-+-----------' unless e == number
    end
  end
end
