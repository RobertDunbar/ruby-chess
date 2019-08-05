class Rook < Piece
    attr_reader :ucode, :colour, :moves

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2656",
            black: "\u265C" }
        @moves = []
    end

    def calc_moves(cell)

    end
end