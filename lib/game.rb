require "./player.rb"
require "./board.rb"

require colorize

class Game
    attr_reader :player_white, :player_black, :board

    def initialize
        @player_white = Player.new(game_io("name"), :white)
        @player_black = Player.new("Player 2 (red)", :black)
        @board = Board.new()
        @current_player = @player1
    end

    def play
        result = ""
        loop do
            result = player_turn(@current_player)
            break if result
            player_switch(@current_player)
        end
        puts "Board is full! No winner" if result == "full"
        puts "#{@current_player.name} is the winner!" if result == "winner"
    end

    def player_turn(player)
        column = ""
        loop do
            puts "Please select a unfilled column number to drop into?"
            column = gets.chomp
            break if check_valid_num?(column) && !@board.columns_full.include?(column)
        end
        row = fill_board(player, column.to_i)
        result = end_of_game?(row, column.to_i)
        @board.show_board(@board.cells)
        result
    end

    def fill_board(player, column)
        for row in 5.downto(0)
            if @board.cells[row][column - 1] == 0
                @board.cells[row][column - 1] = "X" if player.colour == :blue
                @board.cells[row][column - 1] = "Y" if player.colour == :red
                @board.columns_full << column if row == 0
                return row
            end
        end
    end

    def end_of_game?(row, column)
        return "full" if ([1,2,3,4,5,6,7] - @board.columns_full).empty?
        return @board.check_win_lines(row, column - 1)
    end

    def player_switch(player)
        player == @player1 ? @current_player = @player2 : @current_player = @player1
    end

    def check_valid_num? (input)
        return /[1-9]/.match (input)
    end
end


game = Game.new()
game.play