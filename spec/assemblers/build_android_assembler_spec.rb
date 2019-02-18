require "./lib/assemblers/build_android_assembler"

RSpec.describe BuildAndroidAssembler do

  context "with projects and no libs" do

    it "assemble all project" do
      projects = {}
      projects[:applications] = %w(android-project1:app android-project2:app)
      assembler = BuildAndroidAssembler.new(projects)
      
      expect(assembler.build).to eq "./gradlew "\
            "android-project1:app:assembleDebug \\\n"\
            "android-project2:app:assembleDebug"
    end
  end

  context "with no projects but libs" do

    it "assemble all project" do
      projects = {}
      projects[:libraries] = %w(android-project1:library-module-1 android-project2:library-module-2)
      assembler = BuildAndroidAssembler.new(projects)
      
      expect(assembler.build).to eq "./gradlew "\
            "android-project1:library-module-1:assembleAndroidTest \\\n"\
            "android-project2:library-module-2:assembleAndroidTest"
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
        assembler = BuildAndroidAssembler.new(@projects)
        
        expect(assembler.build).to eq "./gradlew "\
            "android-project1:app:assembleDebug \\\n"\
            "android-project2:app:assembleDebug \\\n"\
            "android-project1:library-module-1:assembleAndroidTest \\\n"\
            "android-project2:library-module-2:assembleAndroidTest"
      end
    end

    context "filtering" do

      it "assemble by application" do
        assembler = BuildAndroidAssembler.new(@projects, {filter: "application"})

        expect(assembler.build).to eq "./gradlew android-project1:app:assembleDebug \\\nandroid-project2:app:assembleDebug"
      end

      it "assemble by library" do
        assembler = BuildAndroidAssembler.new(@projects, {filter: "library"})

        expect(assembler.build).to eq "./gradlew "\
            "android-project1:library-module-1:assembleAndroidTest \\\nandroid-project2:library-module-2:assembleAndroidTest"
      end
    end

    context "pass extras to gradle" do

      it "when filtering" do
        assembler = BuildAndroidAssembler.new(@projects, {filter: "application", extras: %w(--verbose --stacktrace) })

        expect(assembler.build).to eq "./gradlew "\
            "android-project1:app:assembleDebug \\\nandroid-project2:app:assembleDebug \\\n"\
            "--verbose --stacktrace"
      end

      it "when not filtering" do
        assembler = BuildAndroidAssembler.new(@projects, {extras: %w(--verbose --stacktrace) })

        expect(assembler.build).to eq "./gradlew "\
            "android-project1:app:assembleDebug \\\nandroid-project2:app:assembleDebug \\\n"\
            "android-project1:library-module-1:assembleAndroidTest \\\nandroid-project2:library-module-2:assembleAndroidTest \\\n"\
            "--verbose --stacktrace"
      end
    end
  end
end