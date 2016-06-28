module A
  class << self
    private
    def b
      puts "lalelu"
    end
  end
end

A.b
