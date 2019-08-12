require "./lib/converter.rb"
require "./lib/pawn.rb"


describe Pawn do
    context "#initialize" do
        it "requires a parameter" do
            expect{ Pawn.new }.to raise_error(ArgumentError)
        end

        it "requires one parameter" do
            expect{ Pawn.new(:white) }.to_not raise_error
        end
    end

    before do
        @pawn = Pawn.new(:white)
    end

    context "#colour" do
        it "colour is set correctly" do
            expect(@pawn.colour).to eq(:white)
        end

        it "can't be changed" do
            expect{ @pawn.colour = :black }.to raise_error(NoMethodError)
        end
    end

    context "#ucode" do
        it "ucode can be read" do
            expect(@pawn.ucode[:white]).to eq("\u2659")
        end
    end

    before do
        @pawn = Pawn.new(:white)
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
        it "check we can move one or two spaces ahead if clear and we start in starting positions" do
            expect(@pawn.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[1, 2], [1, 3]])
        end

        it "check we can only move one space ahead if clear and we don't start in starting positions" do
            @cell = [1, 2]
            expect(@pawn.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[1, 3]])
        end

        it "check we can also take an opposing coloured piece diagonally" do
            @cell = [1, 1]
            @cells[[0, 2]] = @opp_pawn
            @cells[[2, 2]] = @opp_pawn
            expect(@pawn.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[1, 2], [1, 3], [2, 2], [0, 2]])
        end

        it "check we can't take same coloured pieces diagonally" do
            @cell = [1, 1]
            @cells[[0, 2]] = @pawn
            @cells[[2, 2]] = @pawn
            expect(@pawn.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[1, 2], [1, 3]])
        end
    end
end