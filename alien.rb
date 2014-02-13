#!/usr/bin/env ruby
#
# alien.rb
# SWN Alien Generator
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

# This class generates an alien race from tables/alien.json, 
# which has the following attributes:
#
# body_type
# social_structure
# lenses
class Alien
  attr_reader :body_type, :social_structure, :lenses

  def initialize
    json = JSON.parse(File.read('tables/alien.json'))
    @body_type        = json['body_type'].sample
    @social_structure = json['social_structure'].sample
    @lenses           = []
    (1..[2, 2, 3, 4].sample).each { |e| @lenses.push(json['lens'].sample) }
  end

  def to_s
    <<-EOS.unindent
      Body Type: #{@body_type}
      Social Structure: #{@social_structure}
      Lenses: #{@lenses.join(', ')}
      EOS
  end
end


if __FILE__ == $0
  number = (ARGV.shift || 1).to_i
  (1..number).each do |e|
    puts Alien.new
    if number > 1
      puts '-----------+-+-+-----------' unless e == number
    end
  end
end
