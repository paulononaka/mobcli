#!/usr/bin/env ruby

require_relative 'lib/android_assembler'
require_relative 'lib/build_android_parser'
require 'tty-command'

# gradle_subprojects_property = `./gradlew properties --console=plain -q | grep "^subprojects:"`

gradle_subprojects_property = "subprojects: [
            project ':android-project1',
            project ':android-project2',
            project ':android-project1:app',
            project ':android-project2:app',
            project ':android-project1:library-module-1',
            project ':android-project2:library-module-2'
          ]"

first_arg, *_ = ARGV
cmd = TTY::Command.new

case first_arg
when 'build-android'
  parser = BuildAndroidParser.new
  projects = parser.parse_gradle_projects(gradle_subprojects_property)
  params = parser.parse_args(ARGV)
  cmd.run(AndroidAssembler.new(projects, params).build_android)
else
  puts "missing argument: it should have at least one parameter [build-android] or [test]"
  exit 1
end