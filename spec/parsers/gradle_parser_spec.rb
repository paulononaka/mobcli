require 'optparse'
require './lib/parsers/gradle_parser'

RSpec.describe GradleParser do

  before do
    @parser = GradleParser.new
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
      allow(@parser).to receive(:gradle_props).and_return subprojects_property
      @projects = @parser.parse_gradle_projects
    end

    it "parses applications correctly" do
      expect(@projects[:applications]).to eq %w(android-project1:app android-project2:app)
    end

    it "parses libraries correctly" do
      expect(@projects[:libraries]).to eq %w(android-project1:library-module-1 android-project2:library-module-2)
    end
  end
end