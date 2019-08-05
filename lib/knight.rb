class Knight < Piece
    attr_reader :ucode, :colour, :moves

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2658",
            black: "\u265E" }
        @moves = []
    end

    def calc_moves(cell)

    end
end