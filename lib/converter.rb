module Converter

    def sym_to_coord (cell)
        #takes a string, returns an array
        return [cell[0].ord - 97, cell[1].to_i]
    end

    def coord_to_sym (array)
        #takes an array returns a string
        return (array[0] + 97).chr + array[1].to_s
    end

end