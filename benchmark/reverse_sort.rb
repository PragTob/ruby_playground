require 'benchmark/ips'
ARRAY = (1..1_000).to_a.shuffle

Benchmark.ips do |bm|
  bm.report "sort with block" do
    ARRAY.sort do |item, other|
      other <=> item
    end
  end

  bm.report ".sort.reverse" do
    ARRAY.sort.reverse
  end

  bm.report "sort_by -value" do
    ARRAY.sort_by { |value| -value }
  end

  bm.compare!
end
