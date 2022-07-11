class Calculator

    def self.add_values(current_frame, next_frame, third_frame, turn)
        total = current_frame[0]
        if(total === 10)
            return total += current_frame[1] + current_frame[2] if turn === 9
            total += next_frame[0].to_i
            return total += third_frame[0].to_i if total === 20 && turn < 8
            return total += next_frame[1].to_i
        end
        total += current_frame[1]
        if(total === 10)
            return total += current_frame[2] if turn === 9
            return total += next_frame[0]
        end
        total
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