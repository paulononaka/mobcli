require 'optparse'
require './lib/parsers/build_android_parser'

RSpec.describe BuildAndroidParser do

  before do
    @parser = BuildAndroidParser.new
  end

  context "when parsing arguments" do
    context "--filter" do

      it "returns options when filtering by application correctly" do
        params = @parser.parse_args %w(build-android --filter application)

        expect(params[:filter]).to eq('application')
      end

      it "returns options when filtering by library correctly" do
        params = @parser.parse_args %w(build-android --filter library)

        expect(params[:filter]).to eq('library')
      end

      it "exits when do not pass a parameter to --filter" do
        expect { @parser.parse_args %w(build-android --filter) }.to raise_error(OptionParser::MissingArgument, /--filter should receive \[application\] or \[library\]/)
      end

      it "raises error when pass parameter different than application or library to --filter" do
          expect { @parser.parse_args %w(build-android --filter other) }.to raise_error(OptionParser::MissingArgument, /--filter should receive \[application\] or \[library\]/)
      end
    end

    context "when passing extras to gradle" do

      it "returns extras correctly when passing extras after filtering" do
        params = @parser.parse_args %w(build-android --filter application --verbose --stacktrace)

        expect(params[:filter]).to eq('application')
        expect(params[:extras]).to eq(%w(--verbose --stacktrace))
      end

      it "returns extras correctly when passing extras first" do
        params = @parser.parse_args %w(build-android --verbose --stacktrace --filter application)

        expect(params[:filter]).to eq('application')
        expect(params[:extras]).to eq(%w(--verbose --stacktrace))
      end

      it "returns extras even if not filtering" do
        params = @parser.parse_args %w(build-android --verbose --stacktrace)

        expect(params[:filter]).to eq(nil)
        expect(params[:extras]).to eq(%w(--verbose --stacktrace))
      end
    end

    it "exits when option is --help" do
      expect { @parser.parse_args %w(build-android --help) }.to raise_error(ParserExit,
        /Usage: mobcli build-android \[options\]. It assembles applications and libraries from an/)
    end
  end
end