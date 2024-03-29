require './lib/parsers/test_run_parser'

RSpec.describe TestRunParser do

  before do
    @parser = TestRunParser.new
  end

  context "when run" do
    context "--path" do
      it "exits when do not pass --path" do
        expect { @parser.parse_args %w(test run --applicationId br.com.challenge) }.to raise_error(OptionParser::MissingArgument, /--path is required/)
      end

      it "parses --path correctly" do
        params = @parser.parse_args %w(test run --path test_junit_result_1.xml --applicationId br.com.challenge)

        expect(params[:path]).to eq('test_junit_result_1.xml')
      end
    end

    context "--filter" do
      it "parses --filter correctly" do
        params = @parser.parse_args %w(test run --filter failure --path test_junit_result_1.xml --applicationId br.com.challenge)

        expect(params[:filter]).to eq('failure')
      end

      it "exits when pass parameter is different from [failure|passes] to --filter" do
        expect { @parser.parse_args %w(test run --filter other --path test_junit_result_1.xml --applicationId br.com.challenge) }
            .to raise_error(OptionParser::MissingArgument, /--filter should receive one of the options \[failure\|passes\]/)
      end
    end

    context "--applicationId" do
      it "exits when do not pass --applicationId" do
        expect { @parser.parse_args %w(test run --filter failure --path test_junit_result_1.xml failure) }
            .to raise_error(OptionParser::MissingArgument, /--applicationId is required/)
      end

      it "parses --applicationId correctly" do
        params = @parser.parse_args %w(test run --applicationId br.com.challenge --path test_junit_result_1.xml)

        expect(params[:applicationId]).to eq('br.com.challenge')
      end

      it "exits when do not pass a parameter to --applicationId" do
        expect { @parser.parse_args %w(test run --applicationId --path test_junit_result_1.xml) }
            .to raise_error(OptionParser::MissingArgument, /--applicationId a \[applicationId\] is required/)
      end
    end

    it "still parses correctly if order are changed" do
      params = @parser.parse_args %w(test run --filter failure --path test_junit_result_1.xml failure --applicationId br.com.challenge)

      expect(params[:path]).to eq('test_junit_result_1.xml')
      expect(params[:filter]).to eq('failure')
      expect(params[:applicationId]).to eq('br.com.challenge')
    end
  end
end