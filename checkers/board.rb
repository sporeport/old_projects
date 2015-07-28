class Board
  BOARD_SIZE = 8

  attr_accessor :board

  def initialize
    @board = Array.new(BOARD_SIZE) { Array.new(BOARD_SIZE) }
  end

  def fill_board
    (0...BOARD_SIZE).each do |i|
      if i % 2 == 0
        Piece.new(self, [0, i], :red)
        Piece.new(self, [2, i], :red)
        Piece.new(self, [6, i], :black)
      else
        Piece.new(self, [1, i], :red)
        Piece.new(self, [5, i], :black)
        Piece.new(self, [7, i], :black)
      end
    end

    nil
  end

  def [](position)
    row, col = position
    board[row][col]
  end

  def []=(position, value)
    row, col = position
    board[row][col] = value
  end

  def inspect
    board.each_with_index do |row, row_idx|
      row.each_index do |col_idx|
        tile = self[[row_idx, col_idx]]
        tile.nil? ? print("___") : print(tile.display_icon)
      end
      print "\n"
    end

    nil
  end

  def king_me
    pieces.each do |piece|
      if piece.color == :black && piece.position[0] == 0 ||
         piece.color == :red && piece.position[0] == 7
        piece.kinged = true
      end
    end
  end

  def display_board(turn)
    puts "It is #{turn.to_s}'s turn"

    print "\n  "; ("a".."h").each { |l| print " #{l} " }; print "\n"

    board.each_with_index do |row, row_idx|
      print "#{(row_idx - 8).abs.to_s} "
      row.each_index do |col_idx|
        tile = self[[row_idx, col_idx]]
        if (col_idx + row_idx) % 2 == 0
          tile.nil? ? print("   ".colorize(background: :light_white)) :
                      print(tile.display_icon.colorize(color: tile.color, background: :light_white))
        else
          tile.nil? ? print("   ".colorize(color: :red, background: :light_red)) :
                      print(tile.display_icon.colorize(color: tile.color, background: :light_red))
        end
      end
      print " #{(row_idx - 8).abs.to_s}\n"
    end
    print "  "; ("a".."h").each { |l| print " #{l} " }; print "\n"

    nil
  end

  def pieces
    board.flatten.compact
  end

  def dup
    new_board = Board.new

    pieces.each { |piece| piece.dup(new_board) }

    new_board
  end

end
