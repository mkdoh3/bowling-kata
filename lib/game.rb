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

    def add_next_two_rolls
        return @score += roll(2) + roll(3) if tenth_frame?
        return @score += roll(1,1) +  roll(1,2) if roll(1,1) === 10 && normal_frame?
        @score += roll(1,1) + roll(2,1)
    end

    def add_next_roll
        return @score += roll(3) if tenth_frame?
        @score += roll(1,1)
    end

    def roll(ball, step = 0)
        frames[turn + step][ball - 1]
    end

    def calculate_score
        frames.each_index do |index|
            @turn = index
            @score += roll(1)
            next add_next_two_rolls if strike?
            @score += roll(2)
            add_next_roll if spare?
        end
    end
end

