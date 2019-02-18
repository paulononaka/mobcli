#!/usr/bin/env ruby

require_relative 'lib/parsers/mobcli_parser'
require 'tty-command'

result = MobcliParser.new.run

if result[:run]
  begin
    TTY::Command.new.run(result[:output])
  rescue Exception
    exit 1
  end
else
  puts result[:output]
end