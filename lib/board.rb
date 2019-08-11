require_relative "pawn"
require_relative "rook"
require_relative "knight"
require_relative "bishop"
require_relative "queen"
require_relative "king"
require_relative "converter"

class Board
    include Converter

    attr_accessor :cells, :active_pieces, :white_king, :black_king, :king
    attr_reader :pieces

    def initialize
        @taken_white = []
        @taken_black = []
        @active_pieces = { black: [],
                          white: []}
        @king = { black: [],
                  white: []}
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
        @active_pieces[:black] = [[0,7], [7,7], [1,7], [6,7], [2,7], [5,7], [3,7], [4,7]]
        (0..7).each do |col|
            @cells[[col, 6]] = @pieces[:black_pawn]
            @active_pieces[:black] << [col, 6]
        end
        @king[:black] = [4,7]
    end

    def initialize_white
        @cells[[0,0]], @cells[[7,0]] = @pieces[:white_rook], @pieces[:white_rook]
        @cells[[1,0]], @cells[[6,0]] = @pieces[:white_knight], @pieces[:white_knight]
        @cells[[2,0]], @cells[[5,0]] = @pieces[:white_bishop], @pieces[:white_bishop]
        @cells[[3,0]] = @pieces[:white_queen]
        @cells[[4,0]] = @pieces[:white_king]
        @active_pieces[:white] = [[0,0], [7,0], [1,0], [6,0], [2,0], [5,0], [3,0], [4,0]]
        (0..7).each do |col|
            @cells[[col, 1]] = @pieces[:white_pawn]
            @active_pieces[:white] << [col, 1]
        end
        @king[:white] = [4,0]
    end

    def show_board
        # puts `clear`
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
        return @pieces[get_piece(cell)].calc_moves(cell: cell, cells: @cells, start_cell: cell)
    end

    def get_piece(cell)
        return @pieces.key(@cells[cell])
    end

    def take_piece(piece, current_player, move_to)
        @taken_white << piece if piece.colour == :white
        @taken_black << piece if piece.colour == :black
        @active_pieces[:black].delete(move_to) if current_player.colour == :white
        @active_pieces[:white].delete(move_to) if current_player.colour == :black
        true
    end

    def untake_piece(piece, current_player, move_from)
        @taken_white.delete(piece) if piece.colour == :white
        @taken_black.delete(piece) if piece.colour == :black
        @active_pieces[:black].push(move_from) if current_player.colour == :white
        @active_pieces[:white].push(move_from) if current_player.colour == :black
    end

    def track_king(move_from, move_to)
        @king[:white] = move_to if get_piece(move_from) == :white_king
        @king[:black] = move_to if get_piece(move_from) == :black_king
    end

    def track_active_pieces(current_player, move_from, move_to)
        if current_player.colour == :white
            @active_pieces[:white].delete(move_from)
            @active_pieces[:white].push(move_to)
        else
            @active_pieces[:black].delete(move_from)
            @active_pieces[:black].push(move_to)
        end
    end

    def move_piece(move_from, move_to)
        @cells[move_to] = @cells[move_from]
        @cells[move_from] = " "
    end

    def aggregate_attacking_colour_moves(colour)
        piece_moves = []
        @active_pieces[colour].each do |piece|
            piece_moves += calculate_moves(piece)
        end
        piece_moves
    end

    def calculate_computer_moves
        piece_moves = []
        @active_pieces[:black].each do |piece|
            the_moves = calculate_moves(piece)
            piece_moves << [piece, the_moves] if the_moves != []
        end
        piece_moves
    end

    def check_check(moving_colour, opposing_colour)
        attacking_moves = aggregate_attacking_colour_moves(moving_colour)
        check = attacking_moves.uniq.include?(@king[opposing_colour])
    end

    def stalemate(moving_colour, opposing_colour)
        mate = true
        check_king = @king[opposing_colour]
        @active_pieces[opposing_colour].each do |piece|
            defensive_moves = calculate_moves(piece)
            temp_from = @cells[piece]
            defensive_moves.each do |move|
                temp_to = @cells[move]
                check_king = move if @cells[piece].class == King
                move_piece(piece, move)
                piece_moves = aggregate_attacking_colour_moves(moving_colour)
                mate = mate && piece_moves.uniq.include?(check_king)
                check_king = piece if @cells[move].class == King
                @cells[piece], @cells[move] = temp_from, temp_to
            end
        end
        mate
    end

    def check_and_mate(moving_colour, opposing_colour)
        check = check_check(moving_colour, opposing_colour)
        check_king = @king[opposing_colour]
        mate = stalemate(moving_colour, opposing_colour) if check
        return "mate" if mate
        return "check" if check
        false
    end
end
