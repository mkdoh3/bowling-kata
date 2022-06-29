require '../lib/game'

RSpec.describe Game do
    let(:game) { Game.new }
    describe '#score' do
        context "with no strikes or spares" do
            it 'should return the correct score for the given frames' do
            frames = [[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1],[1,1]]
            expect(game.score(frames)).to eq(20)
            end
        end
        context "with strikes and spares throughout" do
            it 'should return the correct score for the given frames' do
            frames = [[1,9],[10],[5,3],[7,2],[6,4],[9,0],[10],[10],[4,3],[5,4]]
            expect(game.score(frames)).to eq(140)
            end
        end
        context "with a spare in the 10th frame" do
            it 'should return the correct score for the given frames' do
            frames = [[1,9],[10],[10],[10],[6,4],[10],[10],[10],[10],[2,8,10]]
            expect(game.score(frames)).to eq(238)
            end
        end
         context "with a strike in every frame" do
            it 'should return the correct score for the given frames' do
            frames = [[10],[10],[10],[10],[10],[10],[10],[10],[10],[10,10,10]]
            expect(game.score(frames)).to eq(300)
            end
        end
    end
end