require '../lib/calculator'

RSpec.describe Calculator do
    describe '.is_ten?' do
        context 'when the sum of the two numbers is 10' do
            it 'returns true' do
                expect(Calculator.is_ten?(5, 5)).to be true
            end
        end

        context 'when the sum of the two numbers is not 10' do
            it 'returns false' do
                expect(Calculator.is_ten?(5, 4)).to be false
            end
        end
    end

    describe '.add_to_total' do
        context 'when given prev total and one number' do
            it 'returns the updated total' do
                expect(Calculator.add_to_total(5, 5)).to be 10
            end
        end

        context 'when given prev total and two numbers' do
            it 'returns the updated total' do
                expect(Calculator.add_to_total(39, 1, 2)).to be 42
            end
        end
    end
end