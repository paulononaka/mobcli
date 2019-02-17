require './lib/android_assembler'

RSpec.describe AndroidAssembler do

  context "with projects and libs" do

    before do
      @subprojects_property = "subprojects: [
            project ':android-project1',
            project ':android-project2',
            project ':android-project1:app',
            project ':android-project2:app',
            project ':android-project1:library-module-1',
            project ':android-project2:library-module-2'
          ]"
    end

    context "without filtering" do
      before do
        @android_parser = AndroidAssembler.new(@subprojects_property)
      end

      it "parses applications correctly" do
        expect(@android_parser.applications).to eq %w(android-project1:app android-project2:app)
      end

      it "parses libraries correctly" do
        expect(@android_parser.libraries).to eq %w(android-project1:library-module-1 android-project2:library-module-2)
      end

      it "assemble all project and libraries" do
        expect(@android_parser.build_android).to eq './gradlew '\
            'android-project1:app '\
            'android-project2:app '\
            'android-project1:library-module-1 '\
            'android-project2:library-module-2'
      end
    end

    context "filtering" do
      it "assemble by application" do
        @android_parser = AndroidAssembler.new(@subprojects_property, { options: { filter: 'application'} })

        expect(@android_parser.build_android).to eq './gradlew android-project1:app android-project2:app'
      end

      it "assemble by library" do
        @android_parser = AndroidAssembler.new(@subprojects_property, { options: { filter: 'library'} })

        expect(@android_parser.build_android).to eq './gradlew '\
            'android-project1:library-module-1 '\
            'android-project2:library-module-2'
      end
    end

    context "pass extras to gradle" do
      it "when filtering" do
        @android_parser = AndroidAssembler.new(@subprojects_property, {
            options: { filter: 'application'},
            extras: %w(--verbose --stacktrace) }
        )

        expect(@android_parser.build_android).to eq './gradlew android-project1:app android-project2:app --verbose --stacktrace'
      end

      it "when not filtering" do
        @android_parser = AndroidAssembler.new(@subprojects_property, { extras: %w(--verbose --stacktrace) })

        expect(@android_parser.build_android).to eq './gradlew '\
            'android-project1:library-module-1 '\
            'android-project2:library-module-2 '\
            '--verbose --stacktrace'
      end
    end
  end
end