require "./lib/converter.rb"
require "./lib/queen.rb"
require "./lib/pawn.rb"


describe Queen do
    context "#initialize" do
        it "requires a parameter" do
            expect{ Queen.new }.to raise_error(ArgumentError)
        end

        it "requires one parameter" do
            expect{ Queen.new(:white) }.to_not raise_error
        end
    end

    before do
        @queen = Queen.new(:white)
    end

    context "#colour" do
        it "colour is set correctly" do
            expect(@queen.colour).to eq(:white)
        end

        it "can't be changed" do
            expect{ @queen.colour = :black }.to raise_error(NoMethodError)
        end
    end

    context "#ucode" do
        it "ucode can be read" do
            expect(@queen.ucode[:white]).to eq("\u2655")
        end
    end

    before do
        @queen = Queen.new(:white)
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
        it "check we can move in all eight directions when clear" do
            expect(@queen.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,2], [3,3], [4,4], [5,5], [6,6], [7,7], [2,0], [0,2], [0,0],
                                                                                            [1,2], [1,3], [1,4], [1,5], [1,6], [1,7], [2,1], [3,1], [4,1],
                                                                                            [5,1], [6,1], [7,1], [0,1], [1,0]])
        end

        it "check we move into spaces taken by an opposing coloured piece but not beyond" do
            @cells[[5, 5]] = @opp_pawn
            @cells[[1, 4]] = @opp_pawn
            expect(@queen.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,2], [3,3], [4,4], [5,5], [2,0], [0,2], [0,0],
                                                                                            [1,2], [1,3], [1,4], [2,1], [3,1], [4,1],
                                                                                            [5,1], [6,1], [7,1], [0,1], [1,0]])
        end

        it "check we move into spaces taken by an opposing coloured piece but not beyond" do
            @cells[[5, 5]] = @white_pawn
            @cells[[1, 4]] = @white_pawn
            expect(@queen.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[2,2], [3,3], [4,4], [2,0], [0,2], [0,0],
                                                                                            [1,2], [1,3], [2,1], [3,1], [4,1],
                                                                                            [5,1], [6,1], [7,1], [0,1], [1,0]])
        end
    end
end