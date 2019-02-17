class AndroidAssembler

  attr_accessor :applications, :libraries

  def initialize(subprojects_property, params = {})
    parse_gradle_property subprojects_property
    @options = params[:options] || {}
    @extras  = params[:extras] || {}
  end

  def build_android
    filter_by = @options[:filter]

    if filter_by.nil?
      params = (@applications + @libraries).join(' ')
    elsif filter_by == 'application'
      params = @applications.join(' ')
    elsif filter_by == 'library'
      params = @libraries.join(' ')
    end

    "./gradlew #{params}"
  end

  private

  def parse_gradle_property(subprojects_property)
    all_projects = subprojects_property.scan(/(?<=project ':).*?(?=')/)
    sub_projects = all_projects.grep(/:/)
    @applications = sub_projects.grep(/app$/)
    @libraries = sub_projects - @applications
  end
end