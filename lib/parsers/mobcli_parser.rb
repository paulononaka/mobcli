require_relative '../assemblers/build_android_assembler'
require_relative '../assemblers/test_assembler'
require_relative '../command_line_arguments'
require_relative '../gradle_projects_property'
require_relative 'build_android_parser'
require_relative 'test_ls_parser'
require_relative 'test_run_parser'
require_relative 'test_report_parser'

class MobcliParser
  include CommandLineArguments
  include GradleProjectsProperty

  def run
    output = {}
    first_arg, second_arg, *_ = argv
    case first_arg
    when 'build-android'
      parser = BuildAndroidParser.new
      projects = parser.parse_gradle_projects(gradle_props)
      params = parser.parse_args(argv)
      output[:run] = true
      output[:output] = BuildAndroidAssembler.new(projects, params).build
    when 'test'
      case second_arg
      when 'ls'; output[:output] = TestAssembler.new(TestLsParser.new.parse_args(argv)).ls
      when 'run'
        output[:run] = true
        output[:output] = TestAssembler.new(TestRunParser.new.parse_args(argv)).run
      when 'report'; output[:output] = TestAssembler.new(TestReportParser.new.parse_args(argv)).report
      else; output[:output] = "missing argument: it should have at least one command `mobcli test [ls|run|report]`."
      end
    else
      output[:output] = "missing argument: it should have at least one parameter `mobcli [build-android|test]`."
    end
    output
  end
end