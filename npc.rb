#!/usr/bin/env ruby
#
# npc.rb
# SWN NPC Generator
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

# This class generates an NPC from tables/npc.yaml, 
# which has the following attributes:
#
# - gender (string)
# - age (string)
# - height (string)
# - problems (string)
# - job_motivation (string)
# - quirk (string)
#
class NPC
  attr_reader :gender, :age, :height, :problems, :job_motivation, :quirk

  def initialize
    yaml = YAML.load(File.read('tables/npc.yaml'))
    names = YAML.load(File.read('tables/npc_names.yaml'))
    @gender         = yaml['gender'].sample.to_str
    @age            = yaml['age'].sample.to_str
    @height         = yaml['height'].sample.to_str
    @problems       = yaml['problems'].sample.to_str
    @job_motivation = yaml['job_motivation'].sample.to_str
    @quirk          = yaml['quirk'].sample.to_str
    @first_name     = names['first_name'].sample.to_str
    @last_name      = names['last_name'].sample.to_str
  end

  def to_s
    <<-EOS.unindent
      |Name: #{@first_name} #{@last_name}
      |Gender: #{@gender}
      |Age: #{@age}
      |Height: #{@height}
      |Problems: #{@problems}
      |Job motivation: #{@job_motivation}
      |Quirk: #{@quirk}
      EOS
  end
end


if __FILE__ == $0
  Integer(ARGV.shift || 1).times do |e|
    puts '-----------+-+-+-----------' unless e.zero?
    puts NPC.new
  end
end
