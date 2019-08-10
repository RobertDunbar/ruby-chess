class Player

    attr_accessor :name, :colour, :computer

    def initialize(name=nil, colour=nil, computer=false)
        @name = name
        @colour = colour
        @computer = computer
    end
end