require './lib/test_run_parser'

RSpec.describe TestRunParser do

  before do
    allow($stdout).to receive(:write)
    @parser = TestRunParser.new
  end

  context "when run" do
    it "exits when do not pass --path" do
      expect { @parser.parse_args %w(tests run)}.to raise_error(SystemExit)
    end

    it "parses --path correctly" do
      params = @parser.parse_args %w(tests run --path test_junit_result_1.xml)

      expect(params[:path]).to eq('test_junit_result_1.xml')
    end

    it "parses --filter correctly" do
      params = @parser.parse_args %w(tests run --filter failure --path test_junit_result_1.xml)

      expect(params[:filter]).to eq('failure')
    end

    it "exits when pass parameter is different from [failure|passes|errors|skipped]" do
      expect { @parser.parse_args %w(tests run --filter other --path test_junit_result_1.xml)}.to raise_error(SystemExit)
    end

    it "parses --applicationId correctly" do
      params = @parser.parse_args %w(tests run --applicationId br.com.challenge --path test_junit_result_1.xml)

      expect(params[:applicationId]).to eq('br.com.challenge')
    end

    it "exits when do not pass a parameter to --applicationId" do
      expect { @parser.parse_args %w(tests run --applicationId --path test_junit_result_1.xml)}.to raise_error(SystemExit)
    end

    it "still parses correctly if order are changed" do
      params = @parser.parse_args %w(tests run --filter failure --path test_junit_result_1.xml failure --applicationId br.com.challenge)

      expect(params[:path]).to eq('test_junit_result_1.xml')
      expect(params[:filter]).to eq('failure')
      expect(params[:applicationId]).to eq('br.com.challenge')
    end
  end
end