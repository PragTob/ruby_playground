require 'benchmark'

Benchmark.bm do |bench|
  bench.report do
    array = (1..1_000).to_a

    array.sort do |item, other|
      other <=> item
    end
  end
end
