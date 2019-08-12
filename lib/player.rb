class Player

    attr_reader :name, :colour, :computer

    def initialize(name, colour, computer=false)
        @name = name
        @colour = colour
        @computer = computer
    end
end