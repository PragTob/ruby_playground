require 'benchmark/ips'

class FakeDimension
  def initialize(margin_start)
    @margin_start = margin_start
  end

  def relative?(result)
    result.is_a?(Float) && result <= 1
  end

  def calculate_relative(result)
    (result * 100).to_i
  end

  define_method :full_meta do
    instance_variable_name = '@' + :margin_start.to_s
    value = instance_variable_get(instance_variable_name)
    value = calculate_relative value if relative? value
    value
  end

  IVAR_NAME = "@margin_start"
  define_method :hoist_ivar_name do
    value = instance_variable_get(IVAR_NAME)
    value = calculate_relative value if relative? value
    value
  end

  define_method :direct_ivar do
    value = @margin_start
    value = calculate_relative value if relative? value
    value
  end

  eval <<-CODE
  def full_string
    value = @margin_start
    value = calculate_relative value if relative? value
    value
  end
  CODE

  def full_direct
    value = @margin_start
    value = calculate_relative value if relative? value
    value
  end
end

def do_benchmark(description, margin_start)
  puts description

  Benchmark.ips do |benchmark|
    dim = FakeDimension.new margin_start
    benchmark.report("full_meta")             { dim.full_meta }
    benchmark.report("hoist_ivar_name")       { dim.hoist_ivar_name }
    benchmark.report("direct_ivar")           { dim.direct_ivar }
    benchmark.report("full_string")           { dim.full_string }
    benchmark.report("full_direct")           { dim.full_direct }
    benchmark.compare!
  end
end

do_benchmark('Non relative margin start', 10)
do_benchmark('Relative margin start', 0.8)
