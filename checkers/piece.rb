class Piece
  SLIDE_DELTAS_BLACK = [[-1, -1], [-1, 1]]
  SLIDE_DELTAS_RED = [[1, 1], [1, -1]]
  JUMP_DELTAS_BLACK = [[-2, -2], [-2, 2]]
  JUMP_DELTAS_RED = [[2, 2], [2, -2]]

  attr_reader :color, :board
  attr_accessor :position

  def initialize(board, position, color)
    @kinged = false
    @board = board
    @color = color  ##:black || :red
    @position = position
    @board[position] = self
  end

  def is_king?
    @kinged
  end

  def kinged=(bool)
    @kinged = true
  end

  def dup(new_board)
    self.class.new(new_board, position, color)
    true
  end

  def preform_moves(seq)
    # debugger
    if valid_move_seq?(seq)
      preform_moves!(seq)
      true
    else
      raise InvalidMoveError.new("Please enter a valid move sequence.")
    end
  end

  def preform_moves!(seq)
    # debugger
    if seq.count == 1
      if !(preform_slide(seq.first) || preform_jump(seq.first))
        raise InvalidMoveError.new("#{seq.first} is and invalid move.")
      end
    else
      seq.each do |move|
        unless preform_jump(move)
          raise InvalidMoveError.new("#{move} is and invalid move.")
        end
      end
    end
  end

  def valid_move_seq?(seq)
    test_board = board.dup

    begin
      test_board[self.position].preform_moves!(seq)
    rescue InvalidMoveError => error
      puts error.message
      false
    else
      true
    end
  end


  def sliding_moves
    slide_moves = []

    my_sliding_delta.each do |delta|
      rel_pos = [position[0] + delta[0], position[1] + delta[1]]
      slide_moves << rel_pos if within_bounds(rel_pos)
    end

    slide_moves.select { |move| empty_space?(move) }
  end

  def within_bounds(moves)
    moves.all? { |coord| coord.between?(0, 7) }
  end

  def empty_space?(pos)
    board[pos] == nil
  end

  def jumping_moves
    jump_moves = []

    my_jumping_delta.each do |delta|
      rel_pos = [position[0] + delta[0], position[1] + delta[1]]
      jump_moves << rel_pos if valid_jump?(position, rel_pos) && within_bounds(rel_pos)
    end

    jump_moves
  end

  def valid_jump?(start_pos, end_pos)
    target_pos = hopped_space(start_pos, end_pos)

    if empty_space?(end_pos) && board[target_pos] != nil
      return true if board[target_pos].color != self.color
    end

    false
  end

  def preform_slide(end_pos)
    # debugger
    if sliding_moves.include?(end_pos)
      move!(position, end_pos)
      true
    else
      false
    end
  end

  def move!(start_pos, end_pos)
    board[end_pos] = self
    self.position = end_pos
    board[start_pos] = nil
  end

  def preform_jump(end_pos)
    if jumping_moves.include?(end_pos)
      board[hopped_space(position, end_pos)] = nil
      move!(position, end_pos)
      true
    else
      false
    end
  end

  def hopped_space(start_pos, end_pos)
    [(start_pos[0] + end_pos[0]) / 2, (start_pos[1] + end_pos[1]) / 2]
  end

  def display_icon
    is_king? ? " ◯ " : " ◉ "
  end

  def my_sliding_delta
    return SLIDE_DELTAS_RED + SLIDE_DELTAS_BLACK if is_king?

    color == :red ? SLIDE_DELTAS_RED : SLIDE_DELTAS_BLACK
  end

  def my_jumping_delta
    return JUMP_DELTAS_RED + JUMP_DELTAS_BLACK if is_king?

    color == :red ? JUMP_DELTAS_RED : JUMP_DELTAS_BLACK
  end
end
