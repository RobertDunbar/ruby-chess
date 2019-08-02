require "./player.rb"
require "./board.rb"

require "colorize"

class Game
    attr_reader :player_white, :player_black, :board

    def initialize
        new_game = game_io("welcome")
        if new_game == "2"
            @player_white = Player.new(game_io("name", "Player 1 (white pieces) :"), :white)
            @player_black = Player.new(game_io("name", "Player 2 (black pieces) :"), :black)
            @board = Board.new()
        end
        @current_player = @player_white
    end

    def play
        result = ""
        loop do
            result = player_turn(@current_player)
            break if result
            player_switch(@current_player)
        end
        # puts "Board is full! No winner" if result == "full"
        # puts "#{@current_player.name} is the winner!" if result == "winner"
    end

    def player_turn(player)
        move_from = ""
        loop do
            puts "Please select a #{player.colour.to_s} piece to move :"
            move_from = gets.chomp.downcase
            p player.colour.to_s
            break if check_valid_cell?(move_from) && get_piece_colour(move_from) == player.colour.to_s
        end
        move_to = ""
        loop do
            puts "Please select a valid cell to move to. Available options : "
            move_to = gets.chomp
            break if check_valid_cell?(move_to)
        end
        # row = fill_board(player, column.to_i)
        # result = end_of_game?(row, column.to_i)
        # @board.show_board(@board.cells)
        # result
    end

    def get_piece_colour(cell)
        return false if @board.cells[cell.to_sym] == " "
        return @board.pieces.key(@board.cells[cell.to_sym])[0..4]
    end

    # def fill_board(player, column)
    #     for row in 5.downto(0)
    #         if @board.cells[row][column - 1] == 0
    #             @board.cells[row][column - 1] = "X" if player.colour == :blue
    #             @board.cells[row][column - 1] = "Y" if player.colour == :red
    #             @board.columns_full << column if row == 0
    #             return row
    #         end
    #     end
    # end

    # def end_of_game?(row, column)
    #     return "full" if ([1,2,3,4,5,6,7] - @board.columns_full).empty?
    #     return @board.check_win_lines(row, column - 1)
    # end

    # def player_switch(player)
    #     player == @player1 ? @current_player = @player2 : @current_player = @player1
    # end

    def check_valid_cell? (input)
        return /[a-z][1-9]/.match (input)
    end

    def game_io(message, add_text="")
        messages = {
            "welcome" => "Welcome to command line chess!\n\n"\
                         "Please enter 1 to load an existing game or 2 to play a new game :",
            "name" => "Please enter the name of",
            "from" => "Please select a cell"
        }
        puts `clear` if message == "welcome"
        case message
        when "welcome"
            puts messages[message]
            loop do
                input = gets.chomp
                return input if input == "1" || input == "2"
            end
        when "name"
            puts "#{messages[message]} #{add_text}"
            return gets.chomp
        end
    end
end


game = Game.new()
game.play