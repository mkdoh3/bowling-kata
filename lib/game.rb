class Game
    attr_accessor :score, :frames, :turn

    def initialize
      @score = 0
      @turn = 0
      @frames = []
    end

    def tenth_frame?
        turn === 9
    end

    def ninth_frame?
        turn === 8
    end

    def normal_frame?
        turn < 8
    end

    def strike?
        roll(1) === 10
    end

    def spare?
        roll(1) + roll(2) === 10
    end

    def total_of_next_two_rolls
        return roll(2) + roll(3) if tenth_frame?
        return roll(1,1) +  roll(1,2) if roll(1,1) === 10 && normal_frame?
        roll(1,1) + roll(2,1)
    end

    def add_strike
        @score += total_of_next_two_rolls
    end

    def add_spare
        @score += roll(2)
        return @score += roll(3) if tenth_frame?
        return @score += roll(1,1)
    end

    def roll(ball, step = 0)
        frames[turn + step][ball - 1]
    end

    def calculate_score
        frames.each_index do |index|
            @turn = index
            @score += roll(1)
            next add_strike if strike?
            next add_spare if spare?
            @score += roll(2)
        end
    end
end

