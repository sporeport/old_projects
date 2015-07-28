require_relative 'board.rb'
require_relative 'game.rb'
require_relative 'piece.rb'
require_relative 'errors.rb'

require 'colorize'
require 'byebug'

if $PROGRAM_NAME == __FILE__

  game = Game.new
  game.play

end
