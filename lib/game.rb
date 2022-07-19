require_relative '../lib/calculator'

class Game
    attr_accessor :frames

    def score
        Calculator.score(frames)
    end


end

