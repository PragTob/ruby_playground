require 'benchmark/ips'

Benchmark.ips do |bm|
  bm.report "Struct.new(...).new" do
    Struct.new(:start, :end).new(10, 20)
  end

  SavedStruct = Struct.new(:start, :end)
  bm.report "SavedStruct.new" do
    SavedStruct.new(10, 20)
  end
end
