require 'optparse'

class TestLsParser

  def parse_args(args)
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: mobcli test ls [options]. It lists all the unit tests in the JUnit XML report."

      opts.on("--path [PATH]", "List the JUnit tests the have failed based on JUnit XML report") do |path|
        raise OptionParser::MissingArgument.new("a [PATH] is required") if path.nil?
        options[:path] = path
      end

      opts.on("-h", "--help", "Prints this help") do
        raise ParserExit, opts
      end
    end

    parser.parse(args)
    raise OptionParser::MissingArgument.new("--path is required") if options[:path].nil?

    options
  end

end