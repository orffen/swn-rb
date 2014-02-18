#!/usr/bin/env ruby
#
# animal.rb
# SWN Animal Generator
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
require 'set'
require './unindent'

# This class generates an animal from tables/animal.json, 
# which has the following attributes:
#
# - template (string)
# - traits (array)
# - group_size (integer)
#
class Animal
  attr_reader :template, :traits, :group_size

  def initialize
    json = JSON.parse(File.read('tables/animal.json'))
    @template   = json['template'].sample.to_s
    @group_size = (1..6).to_a.sample.to_i
    if @template == 'Hybrid'
      num_templates = [2, 2, 3].sample
      templates = Set.new
      while templates.size < num_templates do
        new_template = json['template'].sample.to_s
        templates << new_template unless new_template == 'Hybrid'
      end
      @traits = []
      templates.each { |e| @traits << json['trait'][e.downcase].sample.to_s }
      @template = templates.to_a.join('/')
    else
      @traits = Array(json['trait'][@template.downcase].sample)
    end
  end

  def to_s
    <<-EOS.unindent
      |Template: #{@template}
      |Traits: #{@traits.join(', ')}
      |Group size: #{@group_size}
      EOS
  end
end


if __FILE__ == $0
  (ARGV.shift || 1).to_i.times do |e|
    puts '-----------+-+-+-----------' unless e.zero?
    puts Animal.new
  end
end
