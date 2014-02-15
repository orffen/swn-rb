#!/usr/bin/env ruby
#
# society.rb
# SWN Society Generator
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

# This class generates a society from tables/society.json, 
# which has the following attributes:
#
# colonization_reason
# initial_government_type
# traits
# conflict
# evolution
class Society
  attr_reader :colonization_reason, :initial_government_type, :traits,
    :conflict, :evolution

  def initialize
    json = JSON.parse(File.read('tables/society.json'))
    @colonization_reason     = json['colonization_reason'].sample
    @initial_government_type = json['government_type'].sample
    @conflict                = json['conflict'].sample
    govt = @initial_government_type.downcase.split.join("_")
    @evolution = json['evolution'][govt].sample
    @traits = []
    [2, 3].sample.times { @traits.push json['trait'].sample }
    #TODO: Add a government_type attribute based on the evolution (probably need a regex)
  end

  def to_s
    <<-EOS.unindent
      Colonization Reason: #{@colonization_reason}
      Initial Government Type: #{@initial_government_type}
      Traits: #{@traits.join(", ")}
      Conflict: #{@conflict}
      Evolution: #{@evolution}
      EOS
  end
end


if __FILE__ == $0
  (ARGV.shift || 1).to_i.times do |e|
    puts '-----------+-+-+-----------' unless e == 0
    puts Society.new
  end
end
