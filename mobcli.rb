#!/usr/bin/env ruby

require_relative 'lib/build_android_assembler'
require_relative 'lib/build_android_parser'
require_relative 'lib/test_assembler'
require_relative 'lib/test_ls_parser'
require 'tty-command'

# gradle_props = `./gradlew properties --console=plain -q | grep "^subprojects:"`

gradle_props = "subprojects: [
            project ':android-project1',
            project ':android-project2',
            project ':android-project1:app',
            project ':android-project2:app',
            project ':android-project1:library-module-1',
            project ':android-project2:library-module-2'
          ]"

first_arg, second_arg, *_ = ARGV
cmd = TTY::Command.new

case first_arg
when 'build-android'
  parser = BuildAndroidParser.new
  projects = parser.parse_gradle_projects(gradle_props)
  params = parser.parse_args(ARGV)
  cmd.run(BuildAndroidAssembler.new(projects, params).build)
when 'test'
  case second_arg
  when 'ls'
    puts TestAssembler.new(TestLsParser.new.parse_args(ARGV)).ls
  when 'run'
    puts TestAssembler.new(TestRunParser.new.parse_args(ARGV)).ls
  else
    puts "missing argument: it should have at least one command [mobcli test ls] or [mobcli test run]"
    exit 1
  end
else
  puts "missing argument: it should have at least one parameter [mobcli build-android] or [mobcli test]"
  exit 1
end