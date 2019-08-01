class Board

    attr_accessor :cells, :columns_full

    def initialize
        @cells = Array.new(6) { Array.new(7) { 0 } }
        @columns_full = []
        show_board(cells)
    end

    def show_board(cells)
        for rows in 0..6
            for columns in 0..6
                print "\n\n" if columns == 0 and rows == 1
                if rows == 0
                    print "\t | #{columns + 1} |"
                else
                    print "\t | #{cells[rows-1][columns]} |" if cells[rows-1][columns] == 0
                    print "\t | #{(cells[rows-1][columns]).blue} |" if cells[rows-1][columns] == "X"
                    print "\t | #{(cells[rows-1][columns]).red} |" if cells[rows-1][columns] == "Y"
                end
            end
            puts ""
        end
        puts "\n\n"
    end

    def new_moves_array(row, column)
        new_moves = []
        vertical_moves = []
        horizonal_moves = []
        incline_moves = []
        decline_moves = []
        for i in 1..7
            vertical_moves << [row - (i - 4), column]
            horizonal_moves << [row, column + (i - 4)]
            incline_moves << [row - (i - 4),  column + (i - 4)]
            decline_moves << [row + (i - 4),  column + (i - 4)]
        end
        new_moves << vertical_moves << horizonal_moves << incline_moves << decline_moves
        new_moves.each do |line|
            line.filter! { |pos| pos[0] <= 5 && pos[0] >= 0 && pos[1] <= 6 && pos[1] >= 0 }
        end
        new_moves
    end

    def check_win_lines(row, column)
        new_moves = new_moves_array(row, column)
        marker = cells[row][column]
        result = false
        new_moves.each do |line|
            line.map! { |pos| cells[pos[0]][pos[1]] }
        end
        new_moves.each do |line|
            line_summary = line.chunk { |pos| pos }.map { |char, num| [char, num.length]}
            result = "winner" if line_summary.include?([marker, 4])
        end
        result
    end
end
