array = (1..1_000).to_a

array.sort do |item, other|
  other <=> item
end
