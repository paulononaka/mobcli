require './lib/parsers/build_android_parser'

RSpec.describe BuildAndroidParser do

  before do
    allow($stdout).to receive(:write)
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
        expect { @parser.parse_args %w(build-android --filter)}.to raise_error(SystemExit)
      end

      it "exits when pass parameter is different from application or library" do
        expect { @parser.parse_args %w(build-android --filter other)}.to raise_error(SystemExit)
      end

      it "explains when pass parameter different than application or library to --filter" do
        expect {
          begin @parser.parse_args %w(build-android --filter other)
          rescue SystemExit # ignored
          end
        }.to output("missing argument: --filter should receive [application] or [library]\n").to_stdout
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
      expect { @parser.parse_args %w(build-android --help) }.to raise_error(SystemExit)
    end
  end

  context "when parsing gradle projects" do
    before do
      subprojects_property = "subprojects: [
            project ':android-project1',
            project ':android-project2',
            project ':android-project1:app',
            project ':android-project2:app',
            project ':android-project1:library-module-1',
            project ':android-project2:library-module-2'
          ]"
      @projects = @parser.parse_gradle_projects(subprojects_property)
    end

    it "parses applications correctly" do
      expect(@projects[:applications]).to eq %w(android-project1:app android-project2:app)
    end

    it "parses libraries correctly" do
      expect(@projects[:libraries]).to eq %w(android-project1:library-module-1 android-project2:library-module-2)
    end
  end
end