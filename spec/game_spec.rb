require '../lib/game'

RSpec.describe Game do
    let(:game) { Game.new }

    describe '#ninth_frame?' do
        context 'when it is the 8th turn' do
            it 'returns true' do
                game.turn = 8
                expect(game.ninth_frame?).to be true
            end
        end

        context 'when it is not the 8th turn' do
            it 'returns false' do
                game.turn = 1
                expect(game.ninth_frame?).to be false
            end
        end
    end

    describe '#tenth_frame?' do
        context 'when it is the 9th turn' do
            it 'returns true' do
                game.turn = 9
                expect(game.tenth_frame?).to be true
            end
        end

        context 'when it is not the 9th turn' do
            it 'returns false' do
                game.turn = 1
                expect(game.tenth_frame?).to be false
            end
        end
    end

    describe '#normal_frame?' do
        context 'when the turn number is less than 8' do
            it 'returns true' do
                game.turn = 7
                expect(game.normal_frame?).to be true
            end
        end

        context 'when the turn number is equal to or greater than 8' do
            it 'returns false' do
                game.turn = 9
                expect(game.normal_frame?).to be false
            end
        end
    end

    describe '#strike?' do
        context 'when the first roll of a frame is 10' do
            it 'returns true' do
                game.frames = [[10]]
                expect(game.strike?).to be true
            end
        end

        context 'when the first roll of a frame is not 10' do
            it 'returns false' do
                game.frames = [[1]]
                expect(game.strike?).to be false
            end
        end
    end

    describe '#spare?' do
        context 'when the sum of the first two rolls of a frame is 10' do
            it 'returns true' do
                game.frames = [[1,9]]
                expect(game.spare?).to be true
            end
        end

        context 'when the sum of the first two rolls of a frame is not 10' do
            it 'returns false' do
                game.frames = [[1, 1]]
                expect(game.spare?).to be false
            end
        end
    end

    describe '#add_next_two_rolls' do
        context 'when it is the tenth frame' do
            it 'adds the sum of the 2nd and 3rd roll of the 10th frame to score' do
                game.frames = [[1,1], [1,1], [1,1], [1,1], [1,1], [1,1], [1,1], [1,1], [1,1], [10,1,2]]
                game.turn = 9
                game.add_next_two_rolls
                expect(game.score).to eq(3)
            end
        end

        context 'when it is a normal frame and the following roll is also a strike' do
            it 'adds the sum of the next two rolls of the following 2 frames to score' do
                game.frames = [[10], [10], [1]]
                game.turn = 0
                game.add_next_two_rolls
                expect(game.score).to eq(11)
            end
        end

        context 'when it is a normal frame and the following roll is not a strike' do
            it 'adds sum of the next two rolls of the following frame to score' do
                game.frames = [[10], [1,2]]
                game.turn = 0
                game.add_next_two_rolls
                expect(game.score).to eq(3)
            end
        end
    end

    describe '#add_next_roll' do
        context 'when it is the tenth frame' do
            it 'adds the 3rd roll of the 10th frame to score' do
                game.frames = [[], [], [], [], [], [], [], [], [], [10,1,5]]
                game.turn = 9
                game.add_next_roll
                expect(game.score).to eq(5)
            end
        end

        context 'when it is a normal frame' do
            it 'adds the next roll of the following frame to score' do
                game.frames = [[], [7]]
                game.turn = 0
                game.add_next_roll
                expect(game.score).to eq(7)
            end
        end
    end

    describe '#roll' do
        it 'returns the value of the first roll in the current frame' do
            game.frames = [[1,1]]
            expect(game.roll(1)).to eq(1)
        end
        it 'returns the value of the second roll in the current frame' do
            game.frames = [[1,5]]
            expect(game.roll(2)).to eq(5)
        end
        it 'returns the value of the first roll in the next frame' do
            game.frames = [[],[5]]
            expect(game.roll(1,1)).to eq(5)
        end
        it 'returns the value of the second roll in the next frame' do
            game.frames = [[],[5,4]]
            expect(game.roll(2,1)).to eq(4)
        end
    end

    describe '#calculate_score' do
        context "with no strikes or spares" do
            it 'should return the correct score for the given frames' do
                game.frames = [[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1]]
                game.calculate_score
                expect(game.score).to eq(20)
            end
        end

        context "with strikes and spares throughout" do
            it 'should return the correct score for the given frames' do
                game.frames = [[1,9],[10],[5,3],[7,2],[6,4],[9,0],[10],[10],[4,3],[5,4]]
                game.calculate_score
                expect(game.score).to eq(140)
            end
        end

        context "with a spare in the 10th frame" do
            it 'should return the correct score for the given frames' do
                game.frames = [[1,9],[10],[10],[10],[6,4],[10],[10],[10],[10],[2,8,10]]
                game.calculate_score
                expect(game.score).to eq(238)
            end
        end

        context "with a strike in every frame" do
            it 'should return the correct score for the given frames' do
                game.frames = [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]]
                game.calculate_score
                expect(game.score).to eq(300)
            end
        end
    end
end