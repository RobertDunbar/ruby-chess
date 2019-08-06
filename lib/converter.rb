module Converter

    def string_to_coord (cell)
        return [cell[0].ord - 97, cell[1].to_i - 1]
    end

    def coord_to_string (array)
        return array.map { |coord| (coord[0] + 97).chr + (coord[1] + 1).to_s }
    end

    def coord_move (coord, col, row)
        return [coord[0] + col, coord[1] + row]
    end
end