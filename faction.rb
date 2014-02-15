#!/usr/bin/env ruby
#
# faction.rb
# SWN Faction Generator
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

# This class generates a faction which has the following attributes:
#
# type
# hit_points
# force
# cunning
# wealth
# tags
# assets
#
class Faction
  attr_reader :type, :hit_points, :force, :cunning, :wealth, :tags, :assets

  def initialize
    json        = JSON.parse(File.read('tables/faction.json'))
    @type       = ['minor', 'major', 'hegemon'].sample
    @hit_points = json[@type]['hit_points']
    stats       = json[@type]['stats'].dup
    @force      = stats.delete stats.sample
    @cunning    = stats.delete stats.sample
    @wealth     = stats.delete stats.sample

    @tags = []
    ([1] * 4 + [2]).sample.times { @tags.push json['tags'].sample }

    @assets = []
    # now grab the highest stat value from 'stats'[0] in json
    bigstat = [@force, @cunning, @wealth].index json[@type]['stats'][0]
    stats   = {
      0 => ['force', @force],
      1 => ['cunning', @cunning],
      2 => ['wealth', @wealth]
    }
    json[@type]['assets'][0].times do
      number = (1..stats[bigstat][1]).to_a.sample.to_s # json stores as string
      @assets.push "#{(json[stats[bigstat][0]][number]).sample}/" +
                   "#{stats[bigstat][0].capitalize} #{number}"
    end
    json[@type]['assets'][1].times do
      stat = ([0, 1, 2] - [bigstat]).sample # exclude biggest stat
      number = (1..stats[stat][1]).to_a.sample.to_s # json stores as string
      @assets.push "#{(json[stats[stat][0]][number]).sample}/" +
                   "#{stats[stat][0].capitalize} #{number}"
    end
    @type.capitalize! # we're done using it, so format for output
  end

  def to_s
    <<-EOS.unindent
      Type: #{@type}
      Hit Points: #{@hit_points}
      Force: #{@force}
      Cunning: #{@cunning}
      Wealth: #{@wealth}
      Tags: #{@tags.join(', ')}
      Assets: #{@assets.join(', ')}
      EOS
  end
end


if __FILE__ == $0
  (ARGV.shift || 1).to_i.times do |e|
    puts '-----------+-+-+-----------' unless e == 0
    puts Faction.new
  end
end
