require './lib/test_ls_assembler'

RSpec.describe TestLsAssembler do

  pending "assemble all project" do
    options = {}
    options[:path] = 'test_junit_result_1.xml'
    assembler = TestLsAssembler.new(options)

    expect(assembler.build).to eq 'testNormalFlow\n'\
      'swipeFlow\n'
      'changeOrientation\n'
  end
end