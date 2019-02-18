class BuildAndroidAssembler

  attr_accessor :applications, :libraries

  def initialize(projects, params = {})
    @applications = (projects[:applications] || []).map! { |app| "#{app}:assembleDebug" }
    @libraries = (projects[:libraries] || []).map! { |lib| "#{lib}:assembleAndroidTest" }
    @filter_by = params[:filter]
    @extras = params[:extras]
  end

  def build
    if @filter_by.nil?
      params = (@applications + @libraries).join(" \\\n")
    elsif @filter_by == "application"
      params = @applications.join(" \\\n")
    else @filter_by == "library"
      params = @libraries.join(" \\\n")
    end
    params << " \\\n#{@extras.join(" ")}" unless @extras.nil?

    "./gradlew #{params}"
  end
end