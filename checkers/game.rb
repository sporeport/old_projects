
class Game

  MOVE_KEY = {
    'a' => 0, '8' => 0,
    'b' => 1, '7' => 1,
    'c' => 2, '6' => 2,
    'd' => 3, '5' => 3,
    'e' => 4, '4' => 4,
    'f' => 5, '3' => 5,
    'g' => 6, '2' => 6,
    'h' => 7, '1' => 7
  }

  attr_reader :board
  attr_accessor :winner

  def initialize
    @board = Board.new
    @winner = nil
  end

  def play
    turn = nil
    board.fill_board


    until won?
      turn = (turn == :red ? :black : :red)
      begin
        board.display_board(turn)
        player_move = prompt_player(turn)
        move_peice(player_move, turn)
      rescue CheckersError => error
        puts error
        retry
      end
      board.king_me
    end

    congradulate(turn)
  end

  def move_peice(player_move, turn)
    piece = board[player_move.first]

    if piece.color != turn
      raise NotYourTurnError.new("Please move your own pieces.")
    end

    board[player_move.first].preform_moves(player_move[1..-1])
  end

  def prompt_player(turn)
    puts "#{turn.to_s} type your move/move sequence: "
    puts "example: b3 a4 b6"
    player_move = gets.chomp.downcase
    parse_move(player_move)
  end

  def parse_move(string)
    #
    string.split.map do |str|
      if str.length == 2 && ('a'..'h').include?(str[0]) && (1..8).include?(str[1].to_i)
        [MOVE_KEY[str[1]], MOVE_KEY[str[0]]]
      else
        raise InvalidInputError.new("Pleae enter a correctly formatted sequence")
      end
    end
  end

  def won?
    true if board.pieces.all? { |piece| piece.color == :red } ||
            board.pieces.none? { |piece| piece.color == :red }
    false
  end


end
