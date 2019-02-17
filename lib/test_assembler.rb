require 'danger'
require 'junit/plugin'

class TestAssembler

  def initialize(options = {})
    path = options[:path]
    @junit = Danger::DangerJunit.new(nil)
    @junit.parse path
  end

  def ls
    @junit.tests.map(&:attributes).map { |a| a[:name] }.join("\n")
  end
end