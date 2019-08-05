class Queen < Piece
    attr_reader :ucode, :colour, :moves

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2655",
            black: "\u265B" }
        @moves = []
    end

    def calc_moves(cell)

    end
end