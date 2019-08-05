require "./piece.rb"
require "./pawn.rb"
require "./rook.rb"
require "./knight.rb"
require "./bishop.rb"
require "./queen.rb"
require "./king.rb"

class Board

    attr_accessor :cells, :selected_piece, :available_moves
    attr_reader :pieces

    def initialize
        @selected_piece = nil
        @available_moves = []
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
        ("a".."h").each do |letter|
            (1..8).each do |num|
                @cells[(letter + num.to_s).to_sym] = " "
            end
        end
    end

    def initialize_black
        @cells[:a8], @cells[:h8] = @pieces[:black_rook], @pieces[:black_rook]
        @cells[:b8], @cells[:g8] = @pieces[:black_knight], @pieces[:black_knight]
        @cells[:c8], @cells[:f8] = @pieces[:black_bishop], @pieces[:black_bishop]
        @cells[:d8] = @pieces[:black_queen]
        @cells[:e8] = @pieces[:black_king]
        ("a".."h").each do |col|
            @cells[(col + "7").to_sym] = @pieces[:black_pawn]
        end
    end

    def initialize_white
        @cells[:a1], @cells[:h1] = @pieces[:white_rook], @pieces[:white_rook]
        @cells[:b1], @cells[:g1] = @pieces[:white_knight], @pieces[:white_knight]
        @cells[:c1], @cells[:f1] = @pieces[:white_bishop], @pieces[:white_bishop]
        @cells[:d1] = @pieces[:white_queen]
        @cells[:e1] = @pieces[:white_king]
        ("a".."h").each do |col|
            @cells[(col + "2").to_sym] = @pieces[:white_pawn]
        end
    end

    def show_board
        puts `clear`
        9.downto(0) do |row|
            print "\t"
            (0..9).each do |col|
                char = (col + 97 - 1).chr
                sym = (char + row.to_s).to_sym
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
                        obj = @cells[sym]
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
    end

    def calculate_moves(cell)
        piece_type = @pieces.key(@cells[cell.to_sym])
        @available_moves = @pieces[piece_type].calc_moves(cell, @cells)
        # case piece_type
        # when :black_pawn, :white_pawn
        #     @available_moves = @pieces[piece_type].calc_moves(cell)
        # when :black_rook, :white_rook

        # when :black_knight, :white_knight

        # when :black_bishop, :white_bishop

        # when :black_queen, :white_queen

        # when :black_king, :white_king

        # end
    end

    # def new_moves_array(row, column)
    #     new_moves = []
    #     vertical_moves = []
    #     horizonal_moves = []
    #     incline_moves = []
    #     decline_moves = []
    #     for i in 1..7
    #         vertical_moves << [row - (i - 4), column]
    #         horizonal_moves << [row, column + (i - 4)]
    #         incline_moves << [row - (i - 4),  column + (i - 4)]
    #         decline_moves << [row + (i - 4),  column + (i - 4)]
    #     end
    #     new_moves << vertical_moves << horizonal_moves << incline_moves << decline_moves
    #     new_moves.each do |line|
    #         line.filter! { |pos| pos[0] <= 5 && pos[0] >= 0 && pos[1] <= 6 && pos[1] >= 0 }
    #     end
    #     new_moves
    # end

    # def check_win_lines(row, column)
    #     new_moves = new_moves_array(row, column)
    #     marker = cells[row][column]
    #     result = false
    #     new_moves.each do |line|
    #         line.map! { |pos| cells[pos[0]][pos[1]] }
    #     end
    #     new_moves.each do |line|
    #         line_summary = line.chunk { |pos| pos }.map { |char, num| [char, num.length]}
    #         result = "winner" if line_summary.include?([marker, 4])
    #     end
    #     result
    # end
end
