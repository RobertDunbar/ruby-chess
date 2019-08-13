require "./lib/converter.rb"
require "./lib/game.rb"

describe Game do
    include Converter

    #might be better to split input logic away from game.rb (perhaps into another class)
    #testing become laborious otherwise as you ave to follow input protocol on each test
    before do
        @game = Game.new()
    end

    context "#initialize" do
        it "generates two players and a board in all valid input choices" do
            expect(@game.player_white).to be_instance_of(Player)
            expect(@game.player_black).to be_instance_of(Player)
            expect(@game.board).to be_instance_of(Board)
        end
    end

    context "#check_valid_cell?" do
        it "checks for valid cell input" do
            expect(@game.check_valid_cell?("hh")).to be nil
            expect(@game.check_valid_cell?("f4")).to be_truthy
        end
    end
end