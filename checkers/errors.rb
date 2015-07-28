
class CheckersError < StandardError
end

class InvalidMoveError < CheckersError
end

class InvalidInputError < CheckersError
end

class NotYourTurnError < CheckersError
end
