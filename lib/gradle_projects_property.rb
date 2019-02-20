module GradleProjectsProperty

  def gradle_props
    # "subprojects: [
    #             project ':android-project1',
    #             project ':android-project2',
    #             project ':android-project1:app',
    #             project ':android-project2:app',
    #             project ':android-project1:library-module-1',
    #             project ':android-project2:library-module-2'
    #           ]"
    output = `./gradlew properties --console=plain -q | grep "^subprojects:"`; result = $?.success?
    unless result
      raise ParserExit, "\n*** Do you have a working ./gradlew and a Gradle project setup in this folder? ***\n\n"
    end
    output
  end
end

