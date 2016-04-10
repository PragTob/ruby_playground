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
# Warming up --------------------------------------
# Struct.new(...).new    12.625k i/100ms
# SavedStruct.new   147.232k i/100ms
# 2 element array   179.250k i/100ms
# Hash with 2 keys   119.803k i/100ms
# Calculating -------------------------------------
# Struct.new(...).new    137.801k (± 3.0%) i/s -    694.375k
# SavedStruct.new      4.592M (± 1.7%) i/s -     22.968M
# 2 element array      7.465M (± 1.4%) i/s -     37.463M
# Hash with 2 keys      2.666M (± 1.6%) i/s -     13.418M
#
# Comparison:
#   2 element array:  7464662.6 i/s
# SavedStruct.new:  4592490.5 i/s - 1.63x slower
# Hash with 2 keys:  2665601.5 i/s - 2.80x slower
# Struct.new(...).new:   137801.1 i/s - 54.17x slower

