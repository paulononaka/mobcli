require 'optparse'

class TestReportParser

  def parse_args(args)
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: mobcli test report [options]"

      opts.on("--path [PATH]", "List the JUnit tests the have failed based on JUnit XML report") do |path|
        raise OptionParser::MissingArgument.new("a [PATH] is required") if path.nil?
        options[:path] = path
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    begin
      parser.parse(args)
      raise OptionParser::MissingArgument.new("--path is required") if options[:path].nil?
    rescue Exception => e
      puts e
      exit 1
    end

    options
  end

end