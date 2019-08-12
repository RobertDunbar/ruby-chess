require "./lib/converter.rb"
require "./lib/knight.rb"
require "./lib/pawn.rb"


describe Knight do
    context "#initialize" do
        it "requires a parameter" do
            expect{ Knight.new }.to raise_error(ArgumentError)
        end

        it "requires one parameter" do
            expect{ Knight.new(:white) }.to_not raise_error
        end
    end

    before do
        @knight = Knight.new(:white)
    end

    context "#colour" do
        it "colour is set correctly" do
            expect(@knight.colour).to eq(:white)
        end

        it "can't be changed" do
            expect{ @knight.colour = :black }.to raise_error(NoMethodError)
        end
    end

    context "#ucode" do
        it "ucode can be read" do
            expect(@knight.ucode[:white]).to eq("\u2658")
        end
    end

    before do
        @knight = Knight.new(:white)
        @white_pawn = Pawn.new(:white)
        @opp_pawn = Pawn.new(:black)
        @cells = Hash.new
        (0..7).each do |col|
            (0..7).each do |row|
                @cells[[col, row]] = " "
            end
        end
        @cell = [3, 3]
    end

    context "#calc_moves" do
        it "check we can move in all eight potential moves for the knight" do
            expect(@knight.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[4,5], [5,4], [2,5], [1,4], [4,1], [5,2], [2,1], [1,2]])
        end

        it "check we can move into spaces taken by an opposing coloured piece but not beyond" do
            @cells[[2, 5]] = @opp_pawn
            @cells[[4, 1]] = @opp_pawn
            expect(@knight.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[4,5], [5,4], [2,5], [1,4], [4,1], [5,2], [2,1], [1,2]])
        end

        it "check we cannot move into spaces taken by an same coloured piece" do
            @cells[[2, 5]] = @white_pawn
            @cells[[4, 1]] = @white_pawn
            expect(@knight.calc_moves(cell: @cell, cells: @cells, start_cell: @cell)).to eq([[4,5], [5,4], [1,4], [5,2], [2,1], [1,2]])
        end
    end
end