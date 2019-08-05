class King < Piece
    attr_reader :ucode, :colour, :moves

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2654",
            black: "\u265A" }
        @moves = []
    end

    def calc_moves(cell)

    end
end