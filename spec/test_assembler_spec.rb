require './lib/test_assembler'

RSpec.describe TestAssembler do

  it "ls all tests reported in the junit report passed" do
    options = {}
    options[:path] = 'spec/fixtures/test_junit_result_1.xml'
    assembler = TestAssembler.new(options)

    expect(assembler.ls).to eq "testNormalFlow\nswipeFlow\nchangeOrientation"
  end
end