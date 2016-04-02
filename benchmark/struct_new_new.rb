require 'benchmark/ips'

Benchmark.ips do |bm|
  bm.report "Struct.new(...).new" do
    Struct.new(:start, :end).new(10, 20)
  end

  SavedStruct = Struct.new(:start, :end)
  bm.report "SavedStruct.new" do
    SavedStruct.new(10, 20)
  end

  bm.compare!
end
# Ruby 2.3:
# Calculating -------------------------------------
# Struct.new(...).new    12.074k i/100ms
# SavedStruct.new   155.934k i/100ms
# -------------------------------------------------
# Struct.new(...).new    125.275k (± 4.7%) i/s -    627.848k
# SavedStruct.new      4.798M (± 1.5%) i/s -     24.014M
#
# Comparison:
#   SavedStruct.new:  4797720.9 i/s
# Struct.new(...).new:   125274.7 i/s - 38.30x slower
