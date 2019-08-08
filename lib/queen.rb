require "./converter.rb"

class Queen
    include Converter

    attr_reader :ucode, :colour

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2655",
            black: "\u265B" }
    end

    def calc_moves(cell:, cells:, start_cell:, positions: [], direction: 0)
        self.colour == :white ? opposing_colour = :black : opposing_colour = :white
        return nil if cells[cell].nil?
        if cells[cell] != " "
            return nil if cells[cell].colour == self.colour && cell != start_cell
            return positions << cell if cells[cell].colour == opposing_colour
        end
        positions << cell if cell != start_cell
        if direction == 0
            calc_moves(cell: coord_move(cell, 1, 1), cells: cells, start_cell: start_cell, positions: positions, direction: direction)
            direction += 1 if cell == start_cell
        end
        if direction == 1
            calc_moves(cell: coord_move(cell, 1, -1), cells: cells, start_cell: start_cell, positions: positions, direction: direction)
            direction += 1  if cell == start_cell
        end
        if direction == 2
            calc_moves(cell: coord_move(cell, -1, 1), cells: cells, start_cell: start_cell, positions: positions, direction: direction)
            direction += 1  if cell == start_cell
        end
        if direction == 3
            calc_moves(cell: coord_move(cell, -1, -1), cells: cells, start_cell: start_cell, positions: positions, direction: direction)
            direction += 1  if cell == start_cell
        end
        if direction == 4
            calc_moves(cell: coord_move(cell, 0, 1), cells: cells, start_cell: start_cell, positions: positions, direction: direction)
            direction += 1 if cell == start_cell
        end
        if direction == 5
            calc_moves(cell: coord_move(cell, 1, 0), cells: cells, start_cell: start_cell, positions: positions, direction: direction)
            direction += 1  if cell == start_cell
        end
        if direction == 6
            calc_moves(cell: coord_move(cell, -1, 0), cells: cells, start_cell: start_cell, positions: positions, direction: direction)
            direction += 1  if cell == start_cell
        end
        if direction == 7
            calc_moves(cell: coord_move(cell, 0, -1), cells: cells, start_cell: start_cell, positions: positions, direction: direction)
            direction += 1  if cell == start_cell
        end
        return positions
    end
end