#!/usr/bin/env ruby
#
# npc_name.rb

require './unindent'
require 'yaml'

# This class generates a named pc from tables/npc.yaml,
# tables/npc_names/*.yaml
# which has the following attributes:
#
# - name (string)
#

class NPC_Name
  attr_reader :first_name, :surname, :culture, :gender

  def initialize
    npc = YAML.load(File.read('tables/npc.yaml'))
    @culture    = npc['culture'].sample.to_str
    @gender     = npc['gender'].sample.to_str
    names = YAML.load(File.read('tables/npc_names/'+@culture+'.yaml'))
    @first_name = names[@gender].sample.to_str
    @surname    = names['last_name'].sample.to_str
  end

  def to_s
    <<-EOS.unindent
      |   #{@first_name} #{@surname}
      EOS
  end
end




if __FILE__ == $0
  Integer(ARGV.shift || 1).times do |e|
    # puts '-----------+-+-+-----------' unless e.zero?
    puts NPC_Name.new
  end
end