require "./lib/converter.rb"
require "./lib/rook.rb"
require "./lib/pawn.rb"


describe Rook do
    context "#initialize" do
        it "requires a parameter" do
            expect{ Rook.new }.to raise_error(ArgumentError)
        end

        it "requires one parameter" do
            expect{ Rook.new(:white) }.to_not raise_error
        end
    end

    before do
        @rook = Rook.new(:white)
    end

    context "#colour" do
        it "colour is set correctly" do
            expect(@rook.colour).to eq(:white)
        end

        it "can't be changed" do
            expect{ @rook.colour = :black }.to raise_error(NoMethodError)
        end
    end

    context "#ucode" do
        it "ucode can be read" do
            expect(@rook.ucode[:white]).to eq("\u2656")
        end
    end

    before do
        @rook = Rook.new(:white)
        @white_pawn = Pawn.new(:white)
        @opp_pawn = Pawn.new(:black)
        @cells = Hash.new
        (0..7).each do |col|
            (0..7).each do |row|
                @cells[[col, row]] = " "
            end
        end
        @cell = [1, 1]
    end

    context "#calc_moves" do
        it "check we can move vertically & horizontally to all sqaures if clear" do
            expect(@rook.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[1,2], [1,3], [1,4], [1,5], [1,6], [1,7], [2,1], [3,1], [4,1], [5,1], [6,1], [7,1], [0,1], [1,0]])
        end

        it "check we can move into spaces taken by an opposing coloured piece but not beyond" do
            @cells[[1, 5]] = @opp_pawn
            @cells[[4, 1]] = @opp_pawn
            expect(@rook.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[1,2], [1,3], [1,4], [1,5], [2,1], [3,1], [4,1], [0,1], [1,0]])
        end

        it "check we cannot move into spaces taken by a same coloured piece and not beyond" do
            @cells[[1, 5]] = @white_pawn
            @cells[[4, 1]] = @white_pawn
            expect(@rook.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to  eq([[1,2], [1,3], [1,4], [2,1], [3,1], [0,1], [1,0]])
        end
    end
end