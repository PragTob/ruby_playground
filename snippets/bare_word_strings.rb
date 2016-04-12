def method_missing(*args)
  args.map(&:to_s).join(" ")
end

puts I can haz bareword strings!