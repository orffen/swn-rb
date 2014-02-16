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
# - type (string)
# - hit_points (integer)
# - force (integer)
# - cunning (integer)
# - wealth (integer)
# - tags (array)
# - assets (array)
#
class Faction
  attr_reader :type, :hit_points, :force, :cunning, :wealth, :tags, :assets

  def initialize
    json        = JSON.parse(File.read('tables/faction.json'))
    @type       = ['minor', 'major', 'hegemon'].sample
    @hit_points = json[@type]['hit_points'].to_i
    stats       = json[@type]['stats'].dup
    @force      = (stats.delete stats.sample).to_i
    @cunning    = (stats.delete stats.sample).to_i
    @wealth     = (stats.delete stats.sample).to_i

    @tags = []
    ([1] * 4 + [2]).sample.times { @tags << json['tags'].sample.to_s }

    @assets = []
    # now grab the highest stat value from 'stats'.first in json
    bigstat = [@force, @cunning, @wealth].index json[@type]['stats'].first
    stats   = {
      0 => ['force', @force],
      1 => ['cunning', @cunning],
      2 => ['wealth', @wealth]
    }
    json[@type]['assets'].first.times do
      number = (1..stats[bigstat][1]).to_a.sample.to_s # json stores as string
      @assets << "#{(json[stats[bigstat].first][number]).sample}/" +
                 "#{stats[bigstat].first.capitalize} #{number}"
    end
    json[@type]['assets'][1].times do
      stat = ([0, 1, 2] - [bigstat]).sample # exclude biggest stat
      number = (1..stats[stat][1]).to_a.sample.to_s # json stores as string
      @assets << "#{(json[stats[stat].first][number]).sample}/" +
                 "#{stats[stat].first.capitalize} #{number}"
    end
    @type.capitalize! # we're done using it, so format for output
  end

  def to_s
    <<-EOS.unindent
      |Type: #{@type}
      |Hit Points: #{@hit_points}
      |Force: #{@force}
      |Cunning: #{@cunning}
      |Wealth: #{@wealth}
      |Tags: #{@tags.join(', ')}
      |Assets: #{@assets.join(', ')}
      EOS
  end
end


if __FILE__ == $0
  (ARGV.shift || 1).to_i.times do |e|
    puts '-----------+-+-+-----------' unless e.zero?
    puts Faction.new
  end
end
