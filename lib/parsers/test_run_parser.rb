require 'optparse'

class TestRunParser

  def parse_args(args)
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: mobcli test run [options]. It runs tests through adb based on a JUnit XML report."

      opts.on("--path [PATH]", "List the JUnit tests the have failed based on JUnit XML report") do |path|
        raise OptionParser::MissingArgument.new("a [PATH] is required") if path.nil?
        options[:path] = path
      end

      opts.on("--filter [failure|passes]", "Filter test by type of result") do |filter|
        raise OptionParser::MissingArgument.new("should receive one of the options [failure|passes]") unless
            %w(failure passes errors skipped).include? filter
        options[:filter] = filter
      end

      opts.on("--applicationId [applicationId]", "Informs the applicationId of the project") do |applicationId|
        raise OptionParser::MissingArgument.new("a [applicationId] is required") if applicationId.nil?
        options[:applicationId] = applicationId
      end

      opts.on("-h", "--help", "Prints this help") do
        raise ParserExit, opts
      end
    end

    parser.parse(args)
    raise OptionParser::MissingArgument.new("--path is required") if options[:path].nil?
    raise OptionParser::MissingArgument.new("--applicationId is required") if options[:applicationId].nil?

    options
  end

end