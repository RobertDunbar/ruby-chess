require "./lib/converter.rb"
require "./lib/king.rb"
require "./lib/pawn.rb"


describe King do
    context "#initialize" do
        it "requires a parameter" do
            expect{ King.new }.to raise_error(ArgumentError)
        end

        it "requires one parameter" do
            expect{ King.new(:white) }.to_not raise_error
        end
    end

    before do
        @king = King.new(:white)
    end

    context "#colour" do
        it "colour is set correctly" do
            expect(@king.colour).to eq(:white)
        end

        it "can't be changed" do
            expect{ @king.colour = :black }.to raise_error(NoMethodError)
        end
    end

    context "#ucode" do
        it "ucode can be read" do
            expect(@king.ucode[:white]).to eq("\u2654")
        end
    end

    before do
        @king = King.new(:white)
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
        it "check we can move to all eight surrounding sqaures if clear" do
            expect(@king.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,1], [2,2], [1,2], [2,0], [1,0], [0,0], [0,1], [0,2]])
        end

        it "check we move into spaces taken by an opposing coloured piece" do
            @cells[[0, 2]] = @opp_pawn
            @cells[[2, 2]] = @opp_pawn
            expect(@king.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,1], [2,2], [1,2], [2,0], [1,0], [0,0], [0,1], [0,2]])
        end

        it "check we can't move into spaces taken by a same coloured piece" do
            @cells[[0, 2]] = @white_pawn
            @cells[[2, 2]] = @white_pawn
            expect(@king.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,1], [1,2], [2,0], [1,0], [0,0], [0,1]])
        end
    end
end