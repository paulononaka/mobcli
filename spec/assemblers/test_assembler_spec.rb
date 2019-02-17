require './lib/assemblers/test_assembler'

RSpec.describe TestAssembler do

  context "when ls" do
    it "ls all tests reported in the junit report passed" do
      options = {}
      options[:path] = 'spec/fixtures/test_junit_result_1.xml'
      assembler = TestAssembler.new(options)

      expect(assembler.ls).to eq "testNormalFlow\nswipeFlow\nchangeOrientation"
    end
  end

  context "when run" do
    it "run all tests reported in the junit report passed" do
      options = {}
      options[:path] = 'spec/fixtures/test_junit_result_1.xml'
      options[:applicationId] = 'my.application.id'
      assembler = TestAssembler.new(options)

      expect(assembler.run).to eq "adb shell am instrument "\
        "-w "\
        "-e debug false "\
        "-e class '"\
        "br.com.challenge.test.NewChallenge#testNormalFlow,"\
        "br.com.challenge.test.NewChallenge#swipeFlow,"\
        "br.com.challenge.test.BaseActivity#changeOrientation' "\
        "my.application.id/android.support.test.runner.AndroidJUnitRunner"
    end

    it "run only failed tests when passing --filter failure" do
      options = {}
      options[:path] = 'spec/fixtures/test_junit_result_1.xml'
      options[:filter] = 'failure'
      options[:applicationId] = 'my.application.id'
      assembler = TestAssembler.new(options)

      expect(assembler.run).to eq "adb shell am instrument "\
        "-w "\
        "-e debug false "\
        "-e class '"\
        "br.com.challenge.test.NewChallenge#swipeFlow,"\
        "br.com.challenge.test.BaseActivity#changeOrientation' "\
        "my.application.id/android.support.test.runner.AndroidJUnitRunner"
    end
  end
end