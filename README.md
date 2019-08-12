# Command line chess game

For the rules of chess please check out [The Rules of Chess.](https://www.chessvariants.com/d.chess/chess.html)
Command line chess game, with both single player functionality (playing against simple AI computer that randomly selects a valid move), and double player functionality. Full game save and load functionality. Game status saved in YAML format. Only legal moves are allowed via the game logic. Checks for Check, Stalemate and Check Mate are made after each move. Also includes a fairly comprehensive Rspec test suite to validate code.

## To run
* Clone repo to local machine
* Type Ruby chess.rb to execute
* Type rspec to run test suite

## Built With

* [**Ruby 2.6.3**](https://www.ruby-lang.org/en/)
* [**Colorize Gem 0.8.1**](https://rubygems.org/gems/colorize/versions/0.8.1)

## ToDo

* Implement castling
* Implement en-passant
* Restore taken pieces when pawn reaches end of board

## Authors

* **Robert Dunbar** - *All code*

### Aknowledgements

Part of The Odin Project curriculum https://www.theodinproject.com/courses/ruby-programming/lessons/ruby-final-project



