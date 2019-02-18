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
    `./gradlew properties --console=plain -q | grep "^subprojects:"`
  end
end

