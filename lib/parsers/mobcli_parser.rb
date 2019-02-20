require_relative '../assemblers/build_android_assembler'
require_relative '../assemblers/test_assembler'
require_relative '../command_line_arguments'
require_relative 'build_android_parser'
require_relative 'test_ls_parser'
require_relative 'test_run_parser'
require_relative 'test_report_parser'

class MobcliParser
  include CommandLineArguments

  def run
    result = {}
    first_arg, second_arg, *_ = argv
    case first_arg
    when 'build-android'
      parser = BuildAndroidParser.new
      projects = parser.parse_gradle_projects
      params = parser.parse_args(argv)
      result[:run] = true
      result[:output] = BuildAndroidAssembler.new(projects, params).build
    when 'test'
      case second_arg
      when 'ls'; result[:output] = TestAssembler.new(TestLsParser.new.parse_args(argv)).ls
      when 'run'
        result[:run] = true
        result[:output] = TestAssembler.new(TestRunParser.new.parse_args(argv)).run
      when 'report'; result[:output] = TestAssembler.new(TestReportParser.new.parse_args(argv)).report
      else; result[:output] = "missing argument: it should have at least one command `mobcli test [ls|run|report]`."
      end
    else
      result[:output] = "missing argument: it should have at least one parameter `mobcli [build-android|test]`."
    end

    result
  end
end