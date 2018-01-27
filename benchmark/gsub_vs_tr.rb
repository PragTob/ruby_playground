# frozen_string_literal: true
require 'benchmark/ips'

BASE_STRING = "Some arbitrary string that we want to manipulate"

Benchmark.ips do |bm|
  bm.report("gsub") do
    BASE_STRING.gsub(" ", "_")
  end

  bm.report("tr") do
    BASE_STRING.tr(" ", "_")
  end

  bm.compare!
end
