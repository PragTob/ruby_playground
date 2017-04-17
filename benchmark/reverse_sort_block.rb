require 'benchmark/ips'
ARRAY = (1..1_000).to_a.shuffle

Benchmark.ips do |bm|
  bm.report "reverse sort" do
    ARRAY.sort do |item, other|
      other <=> item
    end
  end
end
