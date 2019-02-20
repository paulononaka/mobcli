require 'optparse'
require_relative '../exceptions/parser_exit'
require_relative '../gradle_projects_property'

class BuildAndroidParser
  include GradleProjectsProperty

  def parse_args(args)
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: mobcli build-android [options]. It assembles applications and libraries from an Android mono-repo multi project.\n\nMake sure to run it in folder with folder with project Gradle Wrapper setup."

      opts.on("--filter [application|library]", "Filter by application or library") do |filter|
        raise OptionParser::MissingArgument.new("should receive [application] or [library]") unless %w(application library).include? filter
        options[:filter] = filter
      end

      opts.on("-h", "--help", "Prints this help") do
        raise ParserExit, opts
      end
    end

    extras = []
    begin
      parser.parse(args)
    rescue OptionParser::InvalidOption => e
      extra = e.args.flatten.first
      extras << extra
      args.delete extra
      retry
    end

    options[:extras] = extras
    options
  end

  def parse_gradle_projects
    projects = {}
    all_projects = gradle_props.scan(/(?<=project ':).*?(?=')/)
    sub_projects = all_projects.grep(/:/)
    projects[:applications] = sub_projects.grep(/app$/)
    projects[:libraries] = sub_projects - projects[:applications]
    projects
  end
end