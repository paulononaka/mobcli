require_relative '../gradle_projects_property'

class GradleParser
  include GradleProjectsProperty

  def parse_gradle_projects
    projects = {}
    all_projects = gradle_props.scan(/(?<=project ':).*?(?=')/)
    sub_projects = all_projects.grep(/:/)
    projects[:applications] = sub_projects.grep(/app$/)
    projects[:libraries] = sub_projects - projects[:applications]
    projects
  end
end