require 'optparse'
require './lib/parsers/test_report_parser'
require './lib/exceptions/parser_exit'

RSpec.describe TestReportParser do

  before do
    @parser = TestReportParser.new
  end

  context "when report" do
    it "parses --path correctly" do
      params = @parser.parse_args %w(test report --path test_junit_result_1.xml)

      expect(params[:path]).to eq('test_junit_result_1.xml')
    end

    it "exits when do not pass --path" do
      expect { @parser.parse_args %w(tests run)}.to raise_error(OptionParser::MissingArgument, /--path is required/)
    end

    it "raises error when do not pass a parameter to --path" do
      expect { @parser.parse_args %w(test report --path) }.to raise_error(OptionParser::MissingArgument, /missing argument: --path a \[PATH\] is required/)
    end

    it "exits when option is --help" do
      expect { @parser.parse_args %w(test report --help) }.to raise_error(ParserExit, /Usage: mobcli test report \[options\]. It generates a Json report based on a JUnit/)
    end
  end
end