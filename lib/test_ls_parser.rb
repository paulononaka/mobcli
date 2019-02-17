require 'optparse'

class TestLsParser

  def parse_args(args)
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: mobcli test ls [options]"

      opts.on("--path [PATH]", "List the JUnit tests the have failed based on JUnit XML report") do |path|
        options[:path] = path
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    parser.parse(args)
    options
  end

end