#!/usr/bin/env ruby
#
# npc.rb
# SWN NPC Generator
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

# This class generates an NPC from tables/npc.json, 
# which has the following attributes:
#
# gender
# age
# height
# problems
# job_motivation
# quirk
class NPC
  attr_reader :founder, :major_npc, :attitude, :quirk

  def initialize
    json = JSON.parse(File.read('tables/npc.json'))
    @gender         = json['gender'].sample
    @age            = json['age'].sample
    @height         = json['height'].sample
    @problems       = json['problems'].sample
    @job_motivation = json['job_motivation'].sample
    @quirk          = json['quirk'].sample
  end

  def to_s
    <<-EOS.unindent
      Gender: #{@gender}
      Age: #{@age}
      Height: #{@height}
      Problems: #{@problems}
      Job motivation: #{@job_motivation}
      Quirk: #{@quirk}
      EOS
  end
end


if __FILE__ == $0
  number = (ARGV.shift || 1).to_i
  (1..number).each do |e|
    puts NPC.new
    if number > 1
      puts '-----------+-+-+-----------' unless e == number
    end
  end
end
