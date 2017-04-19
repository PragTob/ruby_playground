require 'benchmark/ips'

Benchmark.ips do |bm|
  bm.report("Single quotes") do
    'Some teeny tiny string'
  end

  bm.report("Doube quotes") do
    "Some teeny tiny string"
  end

  bm.report("Frozen double quotes") do
    "Some teeny tiny string".freeze
  end

  bm.compare!
end
