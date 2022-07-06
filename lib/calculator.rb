class Calculator
    def self.is_ten?(*numbers)
        numbers.sum === 10
    end

    def self.add_to_total(prev_sum, *numbers)
        prev_sum + numbers.sum
    end
end