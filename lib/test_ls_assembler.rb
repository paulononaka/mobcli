class TestLsAssembler

  attr_accessor :applications, :libraries

  def initialize(options = {})
    @path = options[:path]
  end

  def build
    ""
  end
end