class Bishop < Piece
    attr_reader :ucode, :colour, :moves

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2657",
            black: "\u265D" }
        @moves = []
    end

    def calc_moves(cell)

    end
end