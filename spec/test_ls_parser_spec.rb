require './lib/test_ls_parser'

RSpec.describe TestLsParser do

  before do
    allow($stdout).to receive(:write)
    @parser = TestLsParser.new
  end

  it "parses --path correctly" do
    params = @parser.parse_args %w(tests ls --path test_junit_result_1.xml)

    expect(params[:path]).to eq('test_junit_result_1.xml')
  end

end