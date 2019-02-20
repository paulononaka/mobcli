require 'optparse'
require_relative '../exceptions/parser_exit'

class BuildAndroidParser
  def parse_args(args)
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: mobcli build-android [options]. It assembles applications and libraries from an Android mono-repo multi project.\n\n"\
        "Make sure to run it in folder with project Gradle Wrapper setup and its settings.gradle proper setup.\n"\
        "Be aware that this command only works for \"two levels\" of Gradle multi-project, that is, \n"\
        "the current folder must have Gradle setup and each project must have its own modules.\n\n"

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
end