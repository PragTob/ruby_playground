require 'benchmark/ips'

Benchmark.ips do |bm|
  bm.report "Struct.new(...).new" do
    value = Struct.new(:start, :end).new(10, 20)
    value.start
    value.end
  end

  SavedStruct = Struct.new(:start, :end)
  bm.report "SavedStruct.new" do
    value = SavedStruct.new(10, 20)
    value.start
    value.end
  end

  bm.report "2 element array" do
    value = [10, 20]
    value.first
    value.last
  end

  bm.report "Hash with 2 keys" do
    value = {start: 10, end: 20}
    value[:start]
    value[:end]
  end

  bm.compare!
end

# Ruby 2.3:
# Calculating -------------------------------------
# Struct.new(...).new    11.739k i/100ms
# SavedStruct.new   142.314k i/100ms
# 2 element array   168.250k i/100ms
# Hash with 2 keys   108.454k i/100ms
# -------------------------------------------------
# Struct.new(...).new    111.902k (± 9.3%) i/s -    563.472k
# SavedStruct.new      3.930M (± 5.7%) i/s -     19.639M
# 2 element array      6.911M (± 4.2%) i/s -     34.491M
# Hash with 2 keys      2.418M (± 3.8%) i/s -     12.147M
#
# Comparison:
#   2 element array:  6911144.9 i/s
# SavedStruct.new:  3929604.4 i/s - 1.76x slower
# Hash with 2 keys:  2417552.9 i/s - 2.86x slower
# Struct.new(...).new:   111901.9 i/s - 61.76x slower

