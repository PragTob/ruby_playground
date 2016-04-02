require 'benchmark/ips'

class Try

  def initialize(array)
    @array = array
  end

  define_method :meta_concat_sort do |array|
    value = instance_variable_get '@' + :array.to_s
    new_array = value + array
    new_array.sort
  end

  def concat_sort(array)
    new_array = @array + array
    new_array.sort
  end
end

BASE_ARRAY        = [8, 2, 400, -4, 77]
SMALL_INPUT_ARRAY = [1, 88, -7, 2, 133]
BIG_INPUT_ARRAY   = (1..100).to_a.shuffle


def do_benchmark(description, input)
  puts description
  Benchmark.ips do |b|
    try = Try.new BASE_ARRAY

    b.report('meta_concat_sort') { try.meta_concat_sort(input) }
    b.report('concat_sort')      { try.concat_sort(input) }
    b.compare!
  end
end

do_benchmark('Small input array', SMALL_INPUT_ARRAY)
do_benchmark('Big input array', BIG_INPUT_ARRAY)
