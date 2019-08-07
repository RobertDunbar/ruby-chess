class Piece
    attr_accessor :taken_white

    def initialize()
        @taken_white = []
        @taken_black = []
    end

    def take_piece(piece)
        @taken_white << piece
        p @taken_white
    end

    def restore_piece(piece)

    end

    def check_check

    end

    def check_mate

    end
end