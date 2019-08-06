require "./converter.rb"

class Pawn < Piece
    include Converter

    attr_reader :ucode, :colour

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2659",
            black: "\u265F" }
    end

    def calc_moves(cell, cells, positions=[])
        self.colour == :white ? opposing_colour = :black : opposing_colour = :white
        positions << coord_move(cell, 0, 1) if cells[coord_move(cell, 0, 1)] == " "
        positions << coord_move(cell, 0, 2) if cells[coord_move(cell, 0, 2)] == " " && cell[1] == 1
        take_cell = coord_move(cell, 1, 1)
        if !cells[take_cell].nil? && cells[take_cell] != " "
            positions << take_cell if cells[coord_move(cell, 1, 1)].colour == opposing_colour
        end
        take_cell = coord_move(cell, -1, 1)
        if !cells[take_cell].nil? && cells[take_cell] != " "
            positions << take_cell if cells[coord_move(cell, -1, 1)].colour == opposing_colour
        end
        return positions
    end
end