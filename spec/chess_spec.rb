require "./lib/player.rb"
require "./lib/game.rb"
require "./lib/board.rb"
require "./lib/converter.rb"


RSpec.describe Converter do
    include Converter

    describe "#coord_functions" do
        it "coord move" do
            expect(coord_move([0,0], 2, 3)).to eql([2,3])
        end
        it "coord to string" do
            expect(coord_to_string([[2,3],[3,4]])).to eql(["c4", "d5"])
        end
        it "string to coord" do
            expect(string_to_coord("d5")).to eql([3,4])
        end
    end
end

RSpec.describe

# RSpec.describe Board do
#     board = Board.new()

#     describe "#initialize" do
#         it "player cells" do
#             expect(board.cells).to eql([1, 2, 3, 4, 5, 6, 7, 8, 9])
#         end
#         it "check winning lines" do
#             expect(board.winning_lines).to eql([[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]])
#         end
#     end
# end
