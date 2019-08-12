require "./lib/converter.rb"
require "./lib/bishop.rb"
require "./lib/pawn.rb"


describe Bishop do
    context "#initialize" do
        it "requires a parameter" do
            expect{ Bishop.new }.to raise_error(ArgumentError)
        end

        it "requires one parameter" do
            expect{ Bishop.new(:white) }.to_not raise_error
        end
    end

    before do
        @bishop = Bishop.new(:white)
    end

    context "#colour" do
        it "colour is set correctly" do
            expect(@bishop.colour).to eq(:white)
        end

        it "can't be changed" do
            expect{ @bishop.colour = :black }.to raise_error(NoMethodError)
        end
    end

    context "#ucode" do
        it "ucode can be read" do
            expect(@bishop.ucode[:white]).to eq("\u2657")
        end
    end

    before do
        @bishop = Bishop.new(:white)
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
        it "check we can move diagonally to all sqaures if clear" do
            expect(@bishop.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,2], [3,3], [4,4], [5,5], [6,6], [7,7], [2,0], [0,2], [0,0]])
        end

        it "check we move into spaces taken by an opposing coloured piece but not beyond" do
            @cells[[5, 5]] = @opp_pawn
            @cells[[0, 0]] = @opp_pawn
            expect(@bishop.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,2], [3,3], [4,4], [5,5], [2,0], [0,2], [0,0]])
        end

        it "check we move into spaces taken by an opposing coloured piece but not beyond" do
            @cells[[5, 5]] = @white_pawn
            @cells[[0, 0]] = @white_pawn
            expect(@bishop.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,2], [3,3], [4,4], [2,0], [0,2]])
        end
    end
end