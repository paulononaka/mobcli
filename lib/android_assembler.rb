class AndroidAssembler

  attr_accessor :applications, :libraries

  def initialize(projects, params = {})
    @applications = projects[:applications]
    @libraries = projects[:libraries]
    @filter_by = params[:filter]
    @extras = params[:extras]
  end

  def build_android
    if @filter_by.nil?
      params = (@applications + @libraries).join(' ')
    elsif @filter_by == 'application'
      params = @applications.join(' ')
    else @filter_by == 'library'
      params = @libraries.join(' ')
    end

    params << " #{@extras.join(' ')}" unless @extras.nil?

    "./gradlew #{params}"
  end
end