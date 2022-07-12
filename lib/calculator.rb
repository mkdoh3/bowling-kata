class Calculator

    def self.strike_values(current_frame, next_frame, third_frame, turn)
        return current_frame[1] + current_frame[2] if turn === 9
        return next_frame[0].to_i + third_frame[0].to_i if next_frame[0].to_i === 10 && turn < 8
        next_frame[0].to_i + next_frame[1].to_i
    end

    def self.spare_value(current_frame, next_frame, turn)
        return current_frame[2] if turn === 9
        next_frame[0]
    end


    def self.add_values(current_frame, next_frame, third_frame, turn)
        frame_total = current_frame[0]
        return frame_total += strike_values(current_frame, next_frame, third_frame, turn) if frame_total === 10
        frame_total += current_frame[1]
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