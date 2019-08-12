require "./lib/player.rb"

describe Player do

    context "#initialize" do
        it "requires parameters" do
            expect{ Player.new }.to raise_error(ArgumentError)
        end

        it "requires two parameters" do
            expect{ Player.new("Rob") }.to raise_error(ArgumentError)
        end

        it "works with two paramters" do
            expect{ Player.new("Rob", :black) }.to_not raise_error
        end
    end

    before do
        @player = Player.new("Rob", :white, true)
    end

    context "#name" do
        it "name is set correctly" do
            expect(@player.name).to eq("Rob")
        end

        it "can't be changed" do
            expect{ @player.name = "John" }.to raise_error(NoMethodError)
        end
    end

    context "#colour" do
        it "colour is set correctly" do
            expect(@player.colour).to eq(:white)
        end

        it "can't be changed" do
            expect{ @player.colour = :black }.to raise_error(NoMethodError)
        end
    end

    context "#computer" do
        it "computer is set correctly" do
            expect(@player.computer).to be true
        end

        it "can't be changed" do
            expect{ @player.computer = false }.to raise_error(NoMethodError)
        end
    end
end