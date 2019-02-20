#!/usr/bin/env ruby

require_relative 'lib/parsers/mobcli_parser'
require 'tty-command'

begin
  result = MobcliParser.new.run

  if result[:run]
      TTY::Command.new.run(result[:output])
  else
    puts result[:output]
  end
rescue Exception => e
  puts e
  exit 1
end