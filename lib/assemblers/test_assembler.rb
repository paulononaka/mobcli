require 'danger'
require 'junit/plugin'
require 'json'

class TestAssembler

  def initialize(options = {})
    @junit = Danger::DangerJunit.new(nil)
    @junit.parse options[:path]
    @filter_by = options[:filter]
    @application_id = options[:applicationId]
  end

  def ls
    @junit.tests.map(&:attributes).map { |a| a[:name] }.join("\n")
  end

  def run
    if @filter_by.nil?
      tests = @junit.tests
    elsif @filter_by == 'failure'
      tests = @junit.failures
    else @filter_by == 'passes'
      tests = @junit.passes
    end

    tests_output = tests.map(&:attributes).map { |a| "#{a[:classname]}##{a[:name]}" }.join(",")

    "adb shell am instrument -w -e debug false -e class '#{tests_output}' #{@application_id}/android.support.test.runner.AndroidJUnitRunner"
  end

  def report
    result = @junit.instance_variable_get("@doc").nodes.first.attributes
    JSON.pretty_generate({
      name: result[:name],
      total: result[:tests].to_i,
      failures: result[:failures].to_i,
      success: result[:tests].to_i - result[:failures].to_i
    })
  end
end