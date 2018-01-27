require 'benchmark/ips'

VALUE = "Some value I don't care about"

tables = ("AA".."ZZ").to_a # ("AA".."ZZ").count => 676

def results_for(_)
  VALUE
end

Benchmark.ips do |bm|
  bm.report "reduce" do
    tables.reduce({}) { |hash, table| hash[table] = results_for(table); hash }
  end

  bm.report "each_with_object" do
    tables.each.with_object({}) { |table, hash| hash[table] = results_for(table) }
  end

  bm.report "Hash + zip" do
    Hash[tables.zip(tables.map(&method(:results_for)))]
  end

  bm.report "map to_h" do
    tables.map { |table| [table, results_for(table)] }.to_h   # via Sam Ruby
  end

  bm.report "map merge" do
    tables.map { |table| { table => results_for(table) } }.reduce(:merge)
  end

  bm.report "map merge!" do
    tables.map { |table| { table => results_for(table) } }.reduce(:merge!)
  end

  bm.compare!
end

# CAUTION! ran on battery power.
#
# tobi@comfy ~/github/ruby_playground $ ruby benchmark/hash_creation.rb
# Warming up --------------------------------------
#               reduce   309.000  i/100ms
#     each_with_object   324.000  i/100ms
#           Hash + zip   258.000  i/100ms
#             map to_h   299.000  i/100ms
#            map merge    31.000  i/100ms
#           map merge!   140.000  i/100ms
# Calculating -------------------------------------
#               reduce      3.078k (± 5.8%) i/s -     15.450k in   5.037230s
#     each_with_object      3.022k (±12.2%) i/s -     14.904k in   5.022322s
#           Hash + zip      2.477k (±15.3%) i/s -     12.126k in   5.032726s
#             map to_h      3.294k (± 2.9%) i/s -     16.744k in   5.086917s
#            map merge    303.481  (± 6.9%) i/s -      1.519k in   5.027826s
#           map merge!      1.592k (± 1.8%) i/s -      7.980k in   5.013316s

# Comparison:
#             map to_h:     3294.5 i/s
#               reduce:     3078.0 i/s - same-ish: difference falls within error
#     each_with_object:     3022.0 i/s - same-ish: difference falls within error
#           Hash + zip:     2477.2 i/s - 1.33x  slower
#           map merge!:     1592.3 i/s - 2.07x  slower
#            map merge:      303.5 i/s - 10.86x  slower
