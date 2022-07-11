require_relative '../lib/calculator'

RSpec.describe Calculator do

    describe '.add_values' do

        context 'when the first value of the current frame is 10 (a strike) and the turn is 9' do
            it 'return the sum of the current frame' do
                Calculator.add_values([10,5,5], nil, nil, 9).should eq(20)
            end
        end

        context 'when the current frame is a strike, the next frame is a strike, and the turn is less than 8' do
            it 'return the sum of the current frame, next frame and first value of the third frame' do
                Calculator.add_values([10], [10], [1, 7], 7).should eq(21)
            end
        end

        context 'when the current frame is a strike and the next frame is not' do
            it 'return the sum of the current frame and the next frame' do
                Calculator.add_values([10], [1,9,10], nil, 4).should eq(20)
            end
        end

        context 'when the current frame has two values with the sum of 10 (a spare) and it is the 9th turn' do
            it 'return the sum of the current frame' do
                Calculator.add_values([1,9,4], nil, nil, 9).should eq(14)
            end
        end

        context 'when the current frame has two values with the sum of 10 (a spare) and it is not the 9th turn' do
            it 'return the sum of the current frame and the first rol of the next frame' do
                Calculator.add_values([1,9], [6,4], [1,1], 3).should eq(16)
            end
        end

         context 'when the current frame is not a spare or strike' do
            it 'return the sum of the current frame' do
                Calculator.add_values([1,2], [6,4], [1,1], 1).should eq(3)
            end
        end

    end

    describe '.score' do
        context "with no strikes or spares" do
            it 'should return the correct score for the given frames' do
                frames = [[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1]]
                expect(Calculator.score(frames)).to eq(20)
            end
        end

        context "with strikes and spares throughout" do
            it 'should return the correct score for the given frames' do
                frames = [[1,9],[10],[5,3],[7,2],[6,4],[9,0],[10],[10],[4,3],[5,4]]
                expect(Calculator.score(frames)).to eq(140)
            end
        end

        context "with a spare in the 10th frame" do
            it 'should return the correct score for the given frames' do
                frames = [[1,9],[10],[10],[10],[6,4],[10],[10],[10],[10],[2,8,10]]
                expect(Calculator.score(frames)).to eq(238)
            end
        end

         context "with a strike in every frame" do
            it 'should return the correct score for the given frames' do
                frames = [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]]
                expect(Calculator.score(frames)).to eq(300)
            end
        end
    end
end