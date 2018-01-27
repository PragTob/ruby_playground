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

# tobi@comfy ~/github/ruby_playground $ ruby benchmark/hash_creation.rb
# Warming up --------------------------------------
#               reduce   616.000  i/100ms
#     each_with_object   619.000  i/100ms
#           Hash + zip   523.000  i/100ms
#             map to_h   610.000  i/100ms
#            map merge    49.000  i/100ms
#           map merge!   308.000  i/100ms
# Calculating -------------------------------------
#               reduce      6.220k (± 2.8%) i/s -     31.416k in   5.054703s
#     each_with_object      6.276k (± 3.7%) i/s -     31.569k in   5.037931s
#           Hash + zip      5.499k (± 1.8%) i/s -     27.719k in   5.042398s
#             map to_h      6.343k (± 4.1%) i/s -     31.720k in   5.010349s
#            map merge    454.166  (± 8.8%) i/s -      2.303k in   5.108728s
#           map merge!      3.006k (± 3.7%) i/s -     15.092k in   5.027872s

# Comparison:
#             map to_h:     6343.0 i/s
#     each_with_object:     6275.5 i/s - same-ish: difference falls within error
#               reduce:     6220.3 i/s - same-ish: difference falls within error
#           Hash + zip:     5499.0 i/s - 1.15x  slower
#           map merge!:     3006.0 i/s - 2.11x  slower
#            map merge:      454.2 i/s - 13.97x  slower
