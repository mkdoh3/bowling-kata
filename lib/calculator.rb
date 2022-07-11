class Calculator

    @@frames = []
    @@turn = 0

    def self.tenth_frame?
        @@turn === 9
    end

    def self.ninth_frame?
        @@turn === 8
    end

    def self.normal_frame?
        @@turn < 8
    end

    def self.strike?
        get_roll_value(1) === 10
    end

    def self.spare?
        get_roll_value(1) + get_roll_value(2) === 10
    end

    def self.next_two_roll_values
        return get_roll_value(2) + get_roll_value(3) if tenth_frame?
        return get_roll_value(1,1) +  get_roll_value(1,2) if get_roll_value(1,1) === 10 && normal_frame?
        get_roll_value(1,1) + get_roll_value(2,1)
    end

    def self.next_roll_value
        return get_roll_value(3) if tenth_frame?
        get_roll_value(1,1)
    end

    def self.get_roll_value(roll_num, frame_step = 0)
        @@frames[@@turn + frame_step][roll_num - 1]
    end

    def self.score(frames)
        score = 0
        @@frames = frames
        @@frames.each_index do |index|
            score += get_roll_value(1)
            next score += next_two_rolls if strike?
            score += get_roll_value(2)
            score += next_roll_value if spare?
            @@turn += 1
        end
        score
    end


end