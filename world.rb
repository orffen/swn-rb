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

require './unindent'
require 'yaml'

# This class generates a world from tables/world.yaml, 
# which has the following attributes:
#
# - atmosphere (string)
# - temperature (string)
# - biosphere (string)
# - population (string)
# - tech_level (string)
# - tags (array)
#
class World
  attr_reader :atmosphere, :temperature, :biosphere, :population,
    :tech_level, :tags

  def initialize
    yaml = YAML.load(File.read('tables/world.yaml'))
    @atmosphere  = yaml['atmosphere'].sample.to_str
    @temperature = yaml['temperature'].sample.to_str
    @biosphere   = yaml['biosphere'].sample.to_str
    @population  = yaml['population'].sample.to_str
    @tech_level  = yaml['tech_level'].sample.to_str
    @tags = []
    2.times { tags << yaml['tags'].sample.to_str }
  end

  def to_s
    <<-EOS.unindent
      |Atmosphere: #{@atmosphere}
      |Temperature: #{@temperature}
      |Biosphere: #{@biosphere}
      |Population: #{@population}
      |Tech Level: #{@tech_level}
      |Tags: #{@tags.join(', ')}
      EOS
  end
end


if __FILE__ == $0
  Integer(ARGV.shift || 1).times do |e|
    puts '-----------+-+-+-----------' unless e.zero?
    puts World.new
  end
end
