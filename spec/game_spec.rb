require "./lib/converter.rb"
require "./lib/board.rb"
require "./lib/pawn.rb"
require "./lib/king.rb"
require "./lib/queen.rb"
require "./lib/bishop.rb"
require "./lib/rook.rb"
require "./lib/knight.rb"

require "colorize"

describe Board do
    include Converter

    context "#initialize" do
        it "doesn't require a parameter" do
            expect{ Board.new }.to_not raise_error
        end

        it "generates error with a parameter" do
            expect{ Board.new(:white) }.to raise_error(ArgumentError)
        end
    end

    before do
        @board = Board.new()
    end

    context "#initialize_pieces" do
        it "correct piece and colour is in correct key" do
            expect(@board.pieces[:white_king]).to be_instance_of(King)
            expect(@board.pieces[:white_king].colour).to eq(:white)
        end
    end

    context "#initialize_grid" do
        it "a hash of the correct length is generated to simulate an 8x8 grid filled with starting board"  do
            expect(@board.cells.length).to eq(64)
        end
        it "right colour pieces on right side of board" do
            expect(@board.cells[[4,0]]).to be_instance_of(King)
            expect(@board.cells[[4,0]].colour).to eq(:white)
        end
        it "a space where there is no piece" do
            expect(@board.cells[[3,3]]).to eq(" ")
        end
    end

    context "#initialize_black" do
        it "black king is in the right spot and check the colour"  do
            expect(@board.cells[[4,7]]).to be_instance_of(King)
            expect(@board.cells[[4,7]].colour).to eq(:black)
        end
        it "black pawns are in the right spot and check the colour" do
            expect(@board.cells[[4,6]]).to be_instance_of(Pawn)
            expect(@board.cells[[4,6]].colour).to eq(:black)
        end
        it "pieces are added to active pieces hash" do
            expect(@board.active_pieces[:black].include?([4,7])).to be true
            expect(@board.active_pieces[:black].include?([4,6])).to be true
        end
    end

    context "#initialize_white" do
        it "white king is in the right spot and check the colour"  do
            expect(@board.cells[[4,0]]).to be_instance_of(King)
            expect(@board.cells[[4,0]].colour).to eq(:white)
        end
        it "white pawns are in the right spot and check the colour" do
            expect(@board.cells[[4,1]]).to be_instance_of(Pawn)
            expect(@board.cells[[4,1]].colour).to eq(:white)
        end
        it "pieces are added to active pieces hash" do
            expect(@board.active_pieces[:white].include?([4,0])).to be true
            expect(@board.active_pieces[:white].include?([4,1])).to be true
        end
    end

    before do
        @cell = [1, 1]
    end

    context "#calculate_moves" do
        #Confirming moves for pawn via Board class are the same as the Pawn class directly
        #gives confidence for the other pieces on the board - we can avoid unnecessary replication
        it "Pawn - check we can move one or two spaces ahead if clear and we start in starting positions" do
            expect(@board.calculate_moves(@cell)).to eq([[1, 2], [1, 3]])
        end
        it "Pawn - check we can only move one space ahead if clear and we don't start in starting positions" do
            @board.cells[[1, 2]] = @board.pieces[:white_pawn]
            @cell = [1, 2]
            expect(@board.calculate_moves(@cell)).to eq([[1, 3]])
        end
        it "Pawn - check we can also take an opposing coloured piece diagonally" do
            @board.cells[[1, 2]] = " "
            @cell = [1, 1]
            @board.cells[[0, 2]] = @board.pieces[:black_pawn]
            @board.cells[[2, 2]] = @board.pieces[:black_pawn]
            expect(@board.calculate_moves(@cell)).to eq([[1, 2], [1, 3], [2, 2], [0, 2]])
        end
        it "Pawn - check we can't take same coloured pieces diagonally" do
            @board.cells[[0, 2]] = @board.pieces[:white_pawn]
            @board.cells[[2, 2]] = @board.pieces[:white_pawn]
            expect(@board.calculate_moves(@cell)).to eq([[1, 2], [1, 3]])
        end
    end

    context "#get_piece" do
        it "check it returns the right key for white king"  do
            expect(@board.get_piece([4,0])).to eq(:white_king)
        end
    end

    before do
        @player_black = Player.new("rob", :black)
    end

    context "#take_piece" do
        it "check taken white king is added to correct @taken array"  do
            @board.take_piece(@board.cells[[4,0]], @player_black, [4,0])
            expect(@board.taken_white.include?(@board.pieces[:white_king])).to be true
        end
        it "check taken white king is removed from correct @active_pieces array"  do
            @board.take_piece(@board.cells[[4,0]], @player_black, [4,0])
            expect(@board.active_pieces[:white].include?([4,0])).to be false
        end
    end

    context "#untake_piece" do
        it "check taken white king is removed from correct @taken array"  do
            @board.untake_piece(@board.pieces[:white_king], @player_black, [4,0])
            expect(@board.taken_white.include?(@board.pieces[:white_king])).to be false
        end
        it "check taken white king is added to correct @active_pieces array"  do
            @board.untake_piece(@board.pieces[:white_king], @player_black, [4,0])
            expect(@board.active_pieces[:white].include?([4,0])).to be true
        end
    end

    context "#track_king" do
        it "check it returns the right moved location for white king"  do
            @board.track_king([4,0], [4,4])
            expect(@board.king[:white]).to eq([4,4])
        end
    end

    context "#track_active_pieces" do
        it "check it moves the correct location of black king, deleting the old"  do
            @board.track_active_pieces(@player_black, [4,7], [4,4])
            expect(@board.active_pieces[:black].include?([4,4])).to be true
            expect(@board.active_pieces[:black].include?([4,7])).to be false
        end
    end

    before do
        @board = Board.new()
        @player_white = Player.new("john", :white)
        #move black pawns and white queen to create check mate situation
        @board.track_active_pieces(@player_black, [6,6], [6,4])
        @board.move_piece([6,6], [6,4])
        @board.track_active_pieces(@player_black, [5,6], [5,4])
        @board.move_piece([5,6], [5,4])
        @board.track_active_pieces(@player_white, [3,0], [7,4])
        @board.move_piece([3,0], [7,4])
    end

    context "#check_and_mate" do
        it "check it returns check mate condition for white"  do
            expect(@board.check_and_mate(:white, :black)).to eq(:mate)
        end
    end

    context "#check_check" do
        it "check it returns the check only when its check"  do
            #move pawn back to create check condition only
            @board.track_active_pieces(@player_black, [6,4], [6,6])
            @board.move_piece([6,4], [6,6])
            expect(@board.check_and_mate(:white, :black)).to eq(:check)
        end
    end

    context "#stalemate" do
        it "check it returns the correct stalemate condition"  do
            @board = Board.new()
            (0..7).each do |col|
                (0..7).each do |row|
                    @board.cells[[col, row]] = " "
                end
            end
            @board.cells[[5,7]] = @board.pieces[:black_king]
            @board.cells[[5,6]] = @board.pieces[:white_pawn]
            @board.cells[[5,5]] = @board.pieces[:white_king]
            @board.active_pieces[:black] = [[5,7]]
            @board.active_pieces[:white] = [[5,6], [5,5]]
            @board.king[:white] = [5,5]
            @board.king[:black] = [5,7]
            expect(@board.stalemate(:white, :black)).to be true
        end
    end
end