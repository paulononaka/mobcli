require './lib/android_assembler'

RSpec.describe AndroidAssembler do

  context "with projects and libs" do

    before do
      @projects = {}
      @projects[:applications] = %w(android-project1:app android-project2:app)
      @projects[:libraries] = %w(android-project1:library-module-1 android-project2:library-module-2)
    end

    context "without filtering" do
      before do
        @android_parser = AndroidAssembler.new(@projects)
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
        @android_parser = AndroidAssembler.new(@projects, {filter: 'application'})

        expect(@android_parser.build_android).to eq './gradlew android-project1:app android-project2:app'
      end

      it "assemble by library" do
        @android_parser = AndroidAssembler.new(@projects, {filter: 'library'})

        expect(@android_parser.build_android).to eq './gradlew '\
            'android-project1:library-module-1 android-project2:library-module-2'
      end
    end

    context "pass extras to gradle" do
      it "when filtering" do
        @android_parser = AndroidAssembler.new(@projects, { filter: 'application', extras: %w(--verbose --stacktrace) })

        expect(@android_parser.build_android).to eq './gradlew '\
            'android-project1:app android-project2:app '\
            '--verbose --stacktrace'
      end

      it "when not filtering" do
        @android_parser = AndroidAssembler.new(@projects, {extras: %w(--verbose --stacktrace) })

        expect(@android_parser.build_android).to eq './gradlew '\
            'android-project1:app android-project2:app '\
            'android-project1:library-module-1 android-project2:library-module-2 '\
            '--verbose --stacktrace'
      end
    end
  end
end