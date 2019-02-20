require 'optparse'
require './lib/parsers/test_ls_parser'
require './lib/exceptions/parser_exit'

RSpec.describe TestLsParser do

  before do
    @parser = TestLsParser.new
  end

  context "when ls" do
    it "parses --path correctly" do
      params = @parser.parse_args %w(test ls --path test_junit_result_1.xml)

      expect(params[:path]).to eq('test_junit_result_1.xml')
    end

    it "exits when do not pass --path" do
      expect { @parser.parse_args %w(test ls)}.to raise_error(OptionParser::MissingArgument, /--path is required/)
    end

    it "raises error when do not pass a parameter to --path" do
      expect { @parser.parse_args %w(test ls --path) }.to raise_error(OptionParser::MissingArgument, /missing argument: --path a \[PATH\] is required/)
    end

    it "exits when option is --help" do
      expect { @parser.parse_args %w(test ls --help) }.to raise_error(ParserExit, /Usage: mobcli test ls \[options\]. It lists all the unit tests/)
    end
  end
end