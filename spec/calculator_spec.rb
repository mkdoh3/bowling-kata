require_relative '../lib/calculator'

RSpec.describe Calculator do

    describe '.first_roll' do
        it 'returns the first value of the frame array' do
            expect(Calculator.first_roll([1,2])).to eq(1)
        end
    end

    describe '.second_roll' do
        it 'returns the second value of the frame array' do
            expect(Calculator.second_roll([1,2])).to eq(2)
        end
    end

    describe '.third_roll' do
        it 'returns the third value of the frame array' do
            expect(Calculator.third_roll([1,2,3])).to eq(3)
        end
    end

    describe '.strike_values' do

        it 'returns the sum of the next two rolls' do
            expect(Calculator.strike_values([1,2], [3,4], [5,6], 0)).to eq(7)
        end

        context "with strikes in the next frame and third frame" do
            it 'returns the correct value for the given frames' do
                expect(Calculator.strike_values([10], [10], [10], 0)).to eq(20)
            end
        end

         context "when the turn is 9" do
            it 'returns the value of the 2nd and 3rd roll of the frame' do
                expect(Calculator.strike_values([10, 2, 3], [], [], 9)).to eq(5)
            end
        end
    end

    describe '.spare_value' do

        it 'returns the value of the next roll' do
            expect(Calculator.spare_value([1,9], [5], 0)).to eq(5)
        end

        context "when the turn is 9" do
            it 'returns the value of the 3rd roll of the frame' do
                expect(Calculator.spare_value([7, 3, 5], [], 9)).to eq(5)
            end
        end
    end

    describe '.add_values' do

        context 'when the first value of the current frame is 10 (a strike) and the turn is 9' do
            it 'returns the sum of the current frame' do
                Calculator.add_values([10,5,5], [], [], 9).should eq(20)
            end
        end

        context 'when the current frame is a strike, the next frame is a strike, and the turn is less than 8' do
            it 'returns the sum of the current frame, next frame and first roll of the third frame' do
                Calculator.add_values([10], [10], [1, 7], 7).should eq(21)
            end
        end

        context 'when the current frame is a strike and the next frame is not' do
            it 'returns the sum of the current frame and the next frame' do
                Calculator.add_values([10], [1,9,10], [], 4).should eq(20)
            end
        end

        context 'when the current frame has two values with the sum of 10 (a spare) and it is the 9th turn' do
            it 'returns the sum of the current frame' do
                Calculator.add_values([1,9,4], [], [], 9).should eq(14)
            end
        end

        context 'when the current frame has two values with the sum of 10 (a spare) and it is not the 9th turn' do
            it 'returns the sum of the current frame and the first roll of the next frame' do
                Calculator.add_values([1,9], [6,4], [1,1], 3).should eq(16)
            end
        end

         context 'when the current frame is not a spare or strike' do
            it 'returns the sum of the current frame' do
                Calculator.add_values([1,2], [6,4], [1,1], 1).should eq(3)
            end
        end

    end

    describe '.score' do
        context "with no strikes or spares" do
            it 'returns the correct score for the given frames' do
                frames = [[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1]]
                expect(Calculator.score(frames)).to eq(20)
            end
        end

        context "with strikes and spares throughout" do
            it 'returns the correct score for the given frames' do
                frames = [[1,9],[10],[5,3],[7,2],[6,4],[9,0],[10],[10],[4,3],[5,4]]
                expect(Calculator.score(frames)).to eq(140)
            end
        end

        context "with a spare in the 10th frame" do
            it 'returns the correct score for the given frames' do
                frames = [[1,9],[10],[10],[10],[6,4],[10],[10],[10],[10],[2,8,10]]
                expect(Calculator.score(frames)).to eq(238)
            end
        end

         context "with a strike in every frame" do
            it 'returns the correct score for the given frames' do
                frames = [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]]
                expect(Calculator.score(frames)).to eq(300)
            end
        end
    end
end