require './lib/parsers/mobcli_parser'

RSpec.describe MobcliParser do

  before do
    @mobcli = MobcliParser.new
  end

  it "runs and parse mobcli build-android" do
    allow_any_instance_of(GradleParser).to receive(:gradle_props).and_return "subprojects: [
        project ':android-project1',
        project ':android-project2',
        project ':android-project1:app',
        project ':android-project2:app',
        project ':android-project1:library-module-1',
        project ':android-project2:library-module-2'
      ]"
    allow(@mobcli).to receive(:argv).and_return %w(build-android --filter library --info)

    result = @mobcli.run

    expect(result[:output]).to eq("./gradlew android-project1:library-module-1:assembleAndroidTest \\\n"\
      "android-project2:library-module-2:assembleAndroidTest \\\n"\
      "--info")
  end

  it "runs and parse mobcli test ls" do
    allow(@mobcli).to receive(:argv).and_return %w(test ls --path spec/fixtures/test_junit_result_1.xml)

    result = @mobcli.run

    expect(result[:output]).to eq("testNormalFlow\nswipeFlow\nchangeOrientation")
  end

  it "runs and parse mobcli test run" do
    allow(@mobcli).to receive(:argv).and_return %w(test run --filter failure --applicationId br.package --path spec/fixtures/test_junit_result_1.xml)

    result = @mobcli.run

    expect(result[:output]).to eq("adb shell am instrument \\\n"\
      "-w \\\n"\
      "-e debug false \\\n"\
      "-e class 'br.com.challenge.test.NewChallenge#swipeFlow,br.com.challenge.test.BaseActivity#changeOrientation' \\\n"\
      "br.package/android.support.test.runner.AndroidJUnitRunner")
  end

  it "runs and parse mobcli test report" do
    allow(@mobcli).to receive(:argv).and_return %w(test report --path spec/fixtures/test_junit_result_1.xml)

    result = @mobcli.run

    expect(result[:output]).to eq(
%{{
  "name": "module1-android-api21",
  "total": 3,
  "failures": 2,
  "success": 1
}})
  end

end