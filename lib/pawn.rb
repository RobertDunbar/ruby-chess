require "./converter.rb"

class Pawn < Piece
    include Converter

    attr_reader :ucode, :colour, :moves

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2659",
            black: "\u265F" }
        @moves = []
    end

    def calc_moves(cell, cells)
        pos = sym_to_coord(cell)
        col = pos[0]
        row = pos[1]
        case self.colour
        positions = []
        when :white
            if row == 2
                positions << [col, row + 1] if cells[coord_to_sym([col, row + 1]).to_sym] == " "
                positions << [col, row + 2] if cells[coord_to_sym([col, row + 2]).to_sym] == " "
            else
                positions << [col, row + 1] if cells[coord_to_sym([col, row + 1]).to_sym] == " "
            end
            if cells[coord_to_sym([col - 1 , row + 1]).to_sym] != " " && !cells[coord_to_sym([col - 1 , row + 1]).to_sym].nil?
                positions << [col - 1, row + 1] if cells[coord_to_sym([col - 1 , row + 1]).to_sym].colour == :black
            end
            if cells[coord_to_sym([col + 1 , row + 1]).to_sym] != " " && !cells[coord_to_sym([col + 1 , row + 1]).to_sym].nil?
                positions << [col + 1, row + 1] if cells[coord_to_sym([col + 1 , row + 1]).to_sym].colour == :black
            end
            positions.each do |pos|
                @moves << coord_to_sym(pos)
            end
        when :black
            if row == 7
                positions << [col, row - 1] if cells[coord_to_sym([col, row - 1]).to_sym] == " "
                positions << [col, row - 2] if cells[coord_to_sym([col, row - 2]).to_sym] == " "
            else
                positions << [col, row - 1] if cells[coord_to_sym([col, row - 1]).to_sym] == " "
            end
            if cells[coord_to_sym([col - 1 , row - 1]).to_sym] != " " && !cells[coord_to_sym([col - 1 , row - 1]).to_sym].nil?
                positions << [col - 1, row - 1] if cells[coord_to_sym([col - 1 , row - 1]).to_sym].colour == :white
            end
            if cells[coord_to_sym([col + 1 , row - 1]).to_sym] != " " && !cells[coord_to_sym([col + 1 , row - 1]).to_sym].nil?
                positions << [col + 1, row - 1] if cells[coord_to_sym([col + 1 , row - 1]).to_sym].colour == :white
            end
            positions.each do |pos|
                @moves << coord_to_sym(pos)
            end
        end
        return @moves
    end
end