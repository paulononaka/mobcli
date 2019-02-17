require './lib/build_android_parser'

RSpec.describe BuildAndroidParser do

  before do
    allow($stdout).to receive(:write)
    @android_parser = BuildAndroidParser.new
  end

  context "when filtering" do

    it "returns options when filtering by application correctly" do
      result = @android_parser.parse %w(build-android --filter application)

      expect(result[:options]).to eq({:filter => 'application'})
    end

    it "returns options when filtering by library correctly" do
      result = @android_parser.parse %w(build-android --filter library)

      expect(result[:options]).to eq({:filter => 'library'})
    end

    it "exits when do not pass a parameter to --filter" do
      expect { @android_parser.parse %w(build-android --filter)}.to raise_error(SystemExit)
    end

    it "exits when pass parameter is different from application or library" do
      expect { @android_parser.parse %w(build-android --filter other)}.to raise_error(SystemExit)
    end

    it "explains when pass parameter is different from application or library" do
      expect {
        begin @android_parser.parse %w(build-android --filter other)
        rescue SystemExit # ignored
        end
      }.to output("missing argument: --filter should receive [application] or [library]\n").to_stdout
    end
  end

  context "when passing extras to gradle" do

    it "returns extras correctly when passing extras after filtering" do
      params = @android_parser.parse %w(build-android --filter application --verbose --stacktrace)

      expect(params[:options]).to eq({:filter => 'application'})
      expect(params[:extras]).to eq(%w(--verbose --stacktrace))
    end

    it "returns extras correctly when passing extras first" do
      params = @android_parser.parse %w(build-android --filter application --verbose --stacktrace)

      expect(params[:options]).to eq({:filter => 'application'})
      expect(params[:extras]).to eq(%w(--verbose --stacktrace))
    end

    it "returns extras even if not filtering" do
      params = @android_parser.parse %w(build-android --verbose --stacktrace)

      expect(params[:options]).to eq({})
      expect(params[:extras]).to eq(%w(--verbose --stacktrace))
    end
  end

  it "exits when option is --help" do
    expect { @android_parser.parse %w(build-android --help) }.to raise_error(SystemExit)
  end
end