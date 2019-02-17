require './lib/parsers/test_ls_parser'

RSpec.describe TestLsParser do

  before do
    allow($stdout).to receive(:write)
    @parser = TestLsParser.new
  end

  context "when report" do
    it "parses --path correctly" do
      params = @parser.parse_args %w(test report --path test_junit_result_1.xml)

      expect(params[:path]).to eq('test_junit_result_1.xml')
    end

    it "exits when do not pass --path" do
      expect { @parser.parse_args %w(tests run)}.to raise_error(SystemExit)
    end

    it "exits when do not pass a parameter to --path" do
      expect { @parser.parse_args %w(test report --path)}.to raise_error(SystemExit)
    end

    it "explains when do not pass a parameter to --path" do
      expect {
        begin @parser.parse_args %w(test report --path)
        rescue SystemExit # ignored
        end
      }.to output("missing argument: --path a [PATH] is required\n").to_stdout
    end

    it "exits when option is --help" do
      expect { @parser.parse_args %w(test report --help) }.to raise_error(SystemExit)
    end
  end
end