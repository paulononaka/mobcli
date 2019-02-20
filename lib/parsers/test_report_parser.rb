require 'optparse'

class TestReportParser

  def parse_args(args)
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: mobcli test report [options]. It generates a Json report based on a JUnit XML report."

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