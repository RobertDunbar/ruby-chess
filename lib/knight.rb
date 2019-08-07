require "./converter.rb"

class Knight < Piece
    include Converter

    attr_reader :ucode, :colour

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2658",
            black: "\u265E" }
    end

    def calc_moves(cell:, cells:, start_cell:, positions: [])
        self.colour == :white ? opposing_colour = :black : opposing_colour = :white
        move_cell = coord_move(cell, 1, 2)
        if !cells[move_cell].nil?
            positions << move_cell if cells[move_cell] == " " || cells[move_cell].colour == opposing_colour
        end
        move_cell = coord_move(cell, 2, 1)
        if !cells[move_cell].nil?
            positions << move_cell if cells[move_cell] == " " || cells[move_cell].colour == opposing_colour
        end
        move_cell = coord_move(cell, -1, 2)
        if !cells[move_cell].nil?
            positions << move_cell if cells[move_cell] == " " || cells[move_cell].colour == opposing_colour
        end
        move_cell = coord_move(cell, -2, 1)
        if !cells[move_cell].nil?
            positions << move_cell if cells[move_cell] == " " || cells[move_cell].colour == opposing_colour
        end
        move_cell = coord_move(cell, 1, -2)
        if !cells[move_cell].nil?
            positions << move_cell if cells[move_cell] == " " || cells[move_cell].colour == opposing_colour
        end
        move_cell = coord_move(cell, 2, -1)
        if !cells[move_cell].nil?
            positions << move_cell if cells[move_cell] == " " || cells[move_cell].colour == opposing_colour
        end
        move_cell = coord_move(cell, -1, -2)
        if !cells[move_cell].nil?
            positions << move_cell if cells[move_cell] == " " || cells[move_cell].colour == opposing_colour
        end
        move_cell = coord_move(cell, -2, -1)
        if !cells[move_cell].nil?
            positions << move_cell if cells[move_cell] == " " || cells[move_cell].colour == opposing_colour
        end
        return positions
    end
end