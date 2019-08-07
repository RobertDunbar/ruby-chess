require "./piece.rb"
require "./pawn.rb"
require "./rook.rb"
require "./knight.rb"
require "./bishop.rb"
require "./queen.rb"
require "./king.rb"
require "./converter.rb"

class Board
    include Converter

    attr_accessor :cells, :selected_piece, :available_moves
    attr_reader :pieces, :selected_cell

    def initialize
        @available_moves = []
        @taken_white = []
        @taken_black = []
        initialize_pieces()
        initialize_grid()
        initialize_black()
        initialize_white()
        show_board()
    end

    def initialize_pieces
        @pieces = {
            white_king: King.new(:white),
            white_queen: Queen.new(:white),
            white_rook: Rook.new(:white),
            white_bishop: Bishop.new(:white),
            white_knight: Knight.new(:white),
            white_pawn: Pawn.new(:white),
            black_king: King.new(:black),
            black_queen: Queen.new(:black),
            black_rook: Rook.new(:black),
            black_bishop: Bishop.new(:black),
            black_knight: Knight.new(:black),
            black_pawn: Pawn.new(:black)
        }
    end

    def initialize_grid
        @cells = Hash.new
        (0..7).each do |col|
            (0..7).each do |row|
                @cells[[col, row]] = " "
            end
        end
    end

    def initialize_black
        @cells[[0,7]], @cells[[7,7]] = @pieces[:black_rook], @pieces[:black_rook]
        @cells[[1,7]], @cells[[6,7]] = @pieces[:black_knight], @pieces[:black_knight]
        @cells[[2,7]], @cells[[5,7]] = @pieces[:black_bishop], @pieces[:black_bishop]
        @cells[[3,7]] = @pieces[:black_queen]
        @cells[[4,7]] = @pieces[:black_king]
        (0..7).each do |col|
            @cells[[col, 6]] = @pieces[:black_pawn]
        end
    end

    def initialize_white
        @cells[[0,0]], @cells[[7,0]] = @pieces[:white_rook], @pieces[:white_rook]
        @cells[[1,0]], @cells[[6,0]] = @pieces[:white_knight], @pieces[:white_knight]
        @cells[[2,0]], @cells[[5,0]] = @pieces[:white_bishop], @pieces[:white_bishop]
        @cells[[3,0]] = @pieces[:white_queen]
        @cells[[4,0]] = @pieces[:white_king]
        (0..7).each do |col|
            @cells[[col, 1]] = @pieces[:white_pawn]
        end
    end

    def show_board
        puts `clear`
        9.downto(0) do |row|
            print "\t"
            (0..9).each do |col|
                char = (col + 97 - 1).chr
                case row
                when 0, 9
                    if col != 0 && col != 9
                        print "#{char} ".colorize(:color => :black, :background => :cyan)
                    else
                        print "  ".colorize(:color => :black, :background => :cyan)
                    end
                else
                    if col == 0
                        print "#{row} ".colorize(:color => :black, :background => :cyan)
                    elsif col == 9
                        print " #{row}".colorize(:color => :black, :background => :cyan)
                    else
                        obj = @cells[[col - 1, row - 1]]
                        if obj == " "
                            ucode = obj
                        else
                            colour = obj.colour
                            ucode = obj.ucode[obj.colour]
                        end
                        if (col + row) % 2 == 0
                            print "#{ucode} ".colorize(:color => :black, :background => :blue)
                        else
                            print "#{ucode} ".colorize(:color => :black, :background => :white)
                        end
                    end
                end
            end
            puts ""
        end
        puts ""
        puts "Taken white pieces : #{(@taken_white.map { |piece| piece.ucode[:white] }).join(", ") }"
        puts "Taken black pieces : #{(@taken_black.map { |piece| piece.ucode[:black] }).join(", ") }"
    end

    def calculate_moves(cell)
        piece_type = @pieces.key(@cells[cell])
        @available_moves = @pieces[piece_type].calc_moves(cell: cell, cells: @cells, start_cell: cell)
        @available_moves = coord_to_string(@available_moves)
    end

    def take_piece(piece)
        @taken_white << piece if piece.colour == :white
        @taken_black << piece if piece.colour == :black
    end
end
