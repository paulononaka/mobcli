require 'optparse'
require './lib/parsers/gradle_parser'
require './lib/exceptions/parser_exit'

RSpec.describe GradleParser do

  before do
    @parser = GradleParser.new
  end

  context "when parsing gradle projects" do
    before do
      subprojects_property = "subprojects: [
              project ':spec:gradle_app_fixture',
              project ':spec:gradle_lib_fixture'
          ]"
      allow(@parser).to receive(:gradle_props).and_return subprojects_property
      @projects = @parser.parse_gradle_projects
    end

    it "parses applications correctly" do
      expect(@projects[:applications]).to eq %w(spec:gradle_app_fixture)
    end

    it "parses libraries correctly" do
      expect(@projects[:libraries]).to eq %w(spec:gradle_lib_fixture)
    end
  end
end