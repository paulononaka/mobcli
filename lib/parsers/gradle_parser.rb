require_relative '../gradle_projects_property'

class GradleParser
  include GradleProjectsProperty

  def parse_gradle_projects
    projects = {}
    all_projects = gradle_props.scan(/(?<=project ':).*?(?=')/)
    sub_projects = all_projects.grep(/:/)

    begin
      applications, libraries = sub_projects.partition { |project|
        build_gradle_file = "#{project.gsub(':', '/')}/build.gradle"
        File.readlines(build_gradle_file).grep(/apply plugin: 'com.android.application'/).any?
      }
    rescue Exception => e
      puts e
      raise ParserExit, "\n*** I could not find the build.gradle for your projects :(. Are you running it in a Gradle multi-project setup? ***\n\n"
    end

    projects[:applications] = applications
    projects[:libraries] = libraries
    projects
  end
end