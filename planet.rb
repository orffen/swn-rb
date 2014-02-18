#!/usr/bin/env ruby
#
# planet.rb
# SWN Planet Generator
# This script generates a complete planet with a world description,
# society, fauna, aliens (sometimes), a faction or two, a religion,
# some political parties and NPCs.
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

require './adventure'
require './alien'
require './animal'
require './architecture'
require './corporation'
require './faction'
require './npc'
require './political_party'
require './religion'
require './society'
require './world'
require './unindent'

# This class generates a planet which has the following attributes:
#
# - world (World object)
# - society (Society object)
# - architecture (string)
# - faction (Faction object)
# - political_parties (array of PoliticalParty objects)
# - corporations (array of Corporation object)
# - religions (array of Religion objects)
# - 
#
class Planet
  attr_reader :world, :society, :faction, 

  def initialize
    @world = World.new
    @society = Society.new
  end

  def to_s
    <<-EOS.unindent
      |World:
      |  #{@world}
      |Society:
      |  #{@society}
      |Predominant Architecture: #{@architecture}
      |Strongest Faction:
      |  #{@faction}
      |Political Parties:
      |  #{@political_parties}
      |Corporations:
      |  #{@corporations}
      |Religions:
      |  #{@religions}
      |
      EOS
  end
end


if __FILE__ == $0
  (ARGV.shift || 1).to_i.times do |e|
    puts '-----------+-+-+-----------' unless e.zero?
    puts Adventure.new
  end
end
