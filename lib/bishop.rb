class Bishop < Piece
    attr_reader :ucode, :colour

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2657",
            black: "\u265D" }
    end

    def calc_moves(cell, cells)
        pos = sym_to_coord(cell)
        col = pos[0]
        row = pos[1]
        positions = []
        case self.colour
        when :white

        when :black

        end
    end
end