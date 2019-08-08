require "./player.rb"
require "./board.rb"
require "./converter.rb"

require "colorize"

class Game
    include Converter

    attr_reader :player_white, :player_black, :board

    def initialize
        new_game = game_io("welcome")
        @player_white = Player.new(nil, :white)
        @player_black = Player.new(nil, :black)
        if new_game == "2"
            @player_white.name = game_io("name", "Player 1 (white pieces) :")
            @player_black.name = game_io("name", "Player 2 (black pieces) :")
        end
        @board = Board.new()
        @current_player = @player_white
    end

    def play
        result = ""
        loop do
            result = player_turn(@current_player)
            break if result == "mate"
            player_switch(@current_player)
        end
        puts "#{@current_player.colour} has achieved CHECK MATE!"
    end

    def player_turn(player)
        move_from = move_from_cell()
        move_to = move_to_cell()
        @board.track_king(move_from, move_to) if @board.get_piece(move_from)[-4..-1] == "king"
        @board.take_piece(@board.cells[move_to], @current_player, move_to) if @board.cells[move_to] != " "
        @board.track_active_pieces(current_player, move_from, move_to)
        @board.move_pieces(move_from, move_to)
        @board.show_board
        result = @board.check_and_mate(move_to)
        puts "#{@current_player.colour} has achieved Check!" if result == "check"
    end

    def move_from_cell
        move_from = ""
        available_moves = []
        loop do
            puts "#{player.name}, please select a #{player.colour.to_s} piece to move :"
            move_from = gets.chomp.downcase
            if !check_valid_cell?(move_from)
                puts "Invalid cell entry."
            elsif get_piece_colour(move_from) != player.colour.to_s
                puts "Incorrect piece colour selected."
            else
                move_from = string_to_coord(move_from)
                available_moves = @board.calculate_moves(move_from)
                available_moves = coord_to_string(available_moves)
                break if available_moves != []
                puts "No available moves for this piece. Make another selection."
            end
        end
        move_from
    end

    def move_to_cell
        loop do
            puts "Please select a valid cell to move to. Available options -: #{available_moves.join(", ")} :"
            move_to = gets.chomp
            puts "Please select an availble option." if !available_moves.include?(move_to)
            break if available_moves.include?(move_to)
        end
        move_to = string_to_coord(move_to)
    end

    def get_piece_colour(cell)
        return false if @board.cells[string_to_coord(cell)] == " "
        return @board.pieces.key(@board.cells[string_to_coord(cell)])[0..4]
    end

    def player_switch(player)
        player == @player_white ? @current_player = @player_black : @current_player = @player_white
    end

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