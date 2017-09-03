#!/usr/bin/env ruby
#
# npc_name.rb

require './unindent'
require 'yaml'
require 'optparse'
# This class generates a named pc from tables/npc.yaml,
# tables/npc_names/*.yaml
# which has the following attributes:
#
# - name (string)
#
# Use -c to force a culture

class NPC_Name
  attr_reader :first_name, :surname, :culture, :gender

  def initialize(*cult)
    npc = YAML.load(File.read('tables/npc.yaml'))
    if cult[0].has_key? 'culture'
      # puts cult[0].has_key? 'culture'
      @culture    = cult[0]['culture']
    else
      @culture    = npc['culture'].sample.to_str
    end
    @gender     = npc['gender'].sample.to_str
    names = YAML.load(File.read('tables/npc_names/'+@culture+'.yaml'))
    @first_name = names[@gender].sample.to_str
    @surname    = names['last_name'].sample.to_str
  end

  def to_s
    <<-EOS.unindent
      |   #{@first_name} #{@surname} - #{@gender}
      EOS
  end
end




if __FILE__ == $0
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usuage: npc_name.rb [number] [options]"
    opts.on("-c", "--culture CULTURE", String, 
      "Generate all names with specific culture"){ |o| options['culture'] = o }

  end.parse!
  puts options['culture']
  Integer(ARGV.shift || 1).times do |e|
    # puts '-----------+-+-+-----------' unless e.zero?
    puts NPC_Name.new(options)
  end
end