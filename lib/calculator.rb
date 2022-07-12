class Calculator

    def self.strike_values(current_frame, next_frame, third_frame, turn)
        return second_roll(current_frame) + third_roll(current_frame) if turn === 9
        return first_roll(next_frame) + first_roll(third_frame) if first_roll(next_frame) === 10 && turn < 8
        first_roll(next_frame) + second_roll(next_frame)
    end

    def self.spare_value(current_frame, next_frame, turn)
        return third_roll(current_frame) if turn === 9
        first_roll(next_frame)
    end

    def first_roll(frame)
        frame[0]
    end

    def second_roll(frame)
        frame[1]
    end

    def third_roll(frame)
        frame[2]
    end


    def self.add_values(current_frame, next_frame, third_frame, turn)
        frame_total = first_roll(current_frame)
        return frame_total += strike_values(current_frame, next_frame, third_frame, turn) if frame_total === 10
        frame_total += second_roll(current_frame)
        return frame_total += spare_value(current_frame, next_frame, turn) if frame_total === 10
        frame_total
    end

    def self.score(frames)
        score = 0
        frames.each_with_index do |frame, index|
            current_frame = frame
            next_frame = frames[index + 1]
            third_frame = frames[index + 2]
            score += add_values(current_frame, next_frame, third_frame, index)
        end
        score
    end
end