require 'optparse'

class BuildAndroidParser

  def parse_args(args)
    options = {}
    parser = OptionParser.new do |opts|
      opts.banner = "Usage: mobcli build-android [options]"

      opts.on("--filter [application|library]", "Filter by application or library") do |filter|
        raise OptionParser::MissingArgument.new("should receive [application] or [library]") unless %w(application library).include? filter
        options[:filter] = filter
      end

      opts.on("-h", "--help", "Prints this help") do
        puts opts
        exit
      end
    end

    extras = []
    begin
      parser.parse(args)
    rescue OptionParser::InvalidOption => e
      extra = e.args.flatten.first
      extras << extra
      args.delete extra
      retry
    rescue SystemExit
      exit 1
    rescue Exception => e
      puts e
      exit 1
    end

    options[:extras] = extras
    options
  end

  def parse_gradle_projects(subprojects_property)
    projects = {}
    all_projects = subprojects_property.scan(/(?<=project ':).*?(?=')/)
    sub_projects = all_projects.grep(/:/)
    projects[:applications] = sub_projects.grep(/app$/)
    projects[:libraries] = sub_projects - projects[:applications]
    projects
  end
end