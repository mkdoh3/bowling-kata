class Game
    def score(frames)
        score = 0
        frames.each_with_index do |rolls, frame|
            score += rolls[0]
            next_frame = frames[frame + 1]
            if(rolls[0] === 10) #is it a strike?
                if(frame === 9) #is it the 10th frame?
                    score += rolls[1] + rolls[2]
                elsif(frame === 8) #is it the 9th frame?
                    score += next_frame[0]
                    score += next_frame[1]
                elsif(next_frame[0] === 10) #is the next roll also a strike?
                    score += next_frame[0]
                    score += frames[frame + 2][0]
                else
                    score += next_frame[0]
                    score += next_frame[1]
                end
            elsif(rolls[0] + rolls[1] === 10) #is it a spare?
                if(frame === 9) #is it a spare in the 10th frame?
                    score += rolls[1]
                    score += rolls[2]
                else
                    score += rolls[1]
                    score += next_frame[0]
                end
            else
                score += rolls[1]
            end
        end
        score
    end
end

frames = [[1,9],[10],[10],[10],[6,4],[10],[10],[10],[10],[10,10,10]]
