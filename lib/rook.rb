require "./converter.rb"

class Rook < Piece
    include Converter

    attr_reader :ucode, :colour

    def initialize(colour)
        @colour = colour
        @ucode = {
            white: "\u2656",
            black: "\u265C" }
    end

    def calc_moves(cell, cells, positions=[])
        self.colour == :white ? opposing_colour = :black : opposing_colour = :white
        # positions <<
        return if cells[cell.to_sym].nil? || cells[cell.to_sym].colour == self.colour
        pos = sym_to_coord(cell)
        col = pos[0]
        row = pos[1]
        # positions = []
        colour = self.colour
        # case self.colour
        # when :white
        #     4.times do |num|
        #         case num
        #         when 0
        #             until
        #             positions << [col + 1, row]

        #     end
        # when :black

        # end

    end
end