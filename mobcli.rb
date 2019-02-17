#!/usr/bin/env ruby

require_relative 'lib/android_assembler'
require_relative 'lib/build_android_parser'
require 'tty-command'

#subprojects_property = `/Users/pnonaka/projects/gradlew properties --console=plain -q | grep "^subprojects:"`
subprojects_property = "subprojects: [
            project ':android-project1',
            project ':android-project2',
            project ':android-project1:app',
            project ':android-project2:app',
            project ':android-project1:library-module-1',
            project ':android-project2:library-module-2'
          ]"

first_arg, *the_rest = ARGV
cmd = TTY::Command.new
parser = BuildAndroidParser.new

case first_arg
when 'build-android'
  params = parser.parse(ARGV) unless the_rest.empty?
  cmd.run(AndroidAssembler.new(subprojects_property, params).build_android)
else
  puts "missing argument: it should have at least one parameter [build-android] or [test]"
  exit 1
end