require './lib/build_android_assembler'

RSpec.describe BuildAndroidAssembler do

  context "with projects and no libs" do

    it "assemble all project" do
      projects = {}
      projects[:applications] = %w(android-project1:app android-project2:app)
      parser = BuildAndroidAssembler.new(projects)
      
      expect(parser.build_android).to eq './gradlew '\
            'android-project1:app:assembleDebug '\
            'android-project2:app:assembleDebug'
    end
  end

  context "with no projects but libs" do

    it "assemble all project" do
      projects = {}
      projects[:libraries] = %w(android-project1:library-module-1 android-project2:library-module-2)
      parser = BuildAndroidAssembler.new(projects)
      
      expect(parser.build_android).to eq './gradlew '\
            'android-project1:library-module-1:assembleAndroidTest '\
            'android-project2:library-module-2:assembleAndroidTest'
    end
  end

  context "with projects and libs" do

    before do
      @projects = {}
      @projects[:applications] = %w(android-project1:app android-project2:app)
      @projects[:libraries] = %w(android-project1:library-module-1 android-project2:library-module-2)
    end

    context "without filtering" do

      it "assemble all project and libraries" do
        parser = BuildAndroidAssembler.new(@projects)
        
        expect(parser.build_android).to eq './gradlew '\
            'android-project1:app:assembleDebug '\
            'android-project2:app:assembleDebug '\
            'android-project1:library-module-1:assembleAndroidTest '\
            'android-project2:library-module-2:assembleAndroidTest'
      end
    end

    context "filtering" do

      it "assemble by application" do
        parser = BuildAndroidAssembler.new(@projects, {filter: 'application'})

        expect(parser.build_android).to eq './gradlew android-project1:app:assembleDebug android-project2:app:assembleDebug'
      end

      it "assemble by library" do
        parser = BuildAndroidAssembler.new(@projects, {filter: 'library'})

        expect(parser.build_android).to eq './gradlew '\
            'android-project1:library-module-1:assembleAndroidTest android-project2:library-module-2:assembleAndroidTest'
      end
    end

    context "pass extras to gradle" do

      it "when filtering" do
        parser = BuildAndroidAssembler.new(@projects, {filter: 'application', extras: %w(--verbose --stacktrace) })

        expect(parser.build_android).to eq './gradlew '\
            'android-project1:app:assembleDebug android-project2:app:assembleDebug '\
            '--verbose --stacktrace'
      end

      it "when not filtering" do
        parser = BuildAndroidAssembler.new(@projects, {extras: %w(--verbose --stacktrace) })

        expect(parser.build_android).to eq './gradlew '\
            'android-project1:app:assembleDebug android-project2:app:assembleDebug '\
            'android-project1:library-module-1:assembleAndroidTest android-project2:library-module-2:assembleAndroidTest '\
            '--verbose --stacktrace'
      end
    end
  end
end