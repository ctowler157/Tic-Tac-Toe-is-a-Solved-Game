require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if board.over?
      return false if board.winner == evaluator || board.tied?
      return true
    end
    child_array = children
    if evaluator != next_mover_mark
      return true if child_array.any? { |child| child.losing_node?(evaluator) }
    end
    return false unless child_array.all? { |child| child.losing_node?(evaluator) }
    # children.each do |child|
    #   losing = child.losing_node?(evaluator)
    #   return true if evaluator != next_mover_mark && losing
    #   return false unless losing
    # end

    true
  end

  def winning_node?(evaluator)
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    child_array = []

    board.rows.each_with_index do |row, i|
      row.each_index do |j|
        if board.empty?([i, j])
          child_board = board.dup
          child_board[[i, j]] = next_mover_mark
          child_prev_move = [i, j]
          child_next_mark = (next_mover_mark == :x ? :o : :x)
          child = TicTacToeNode.new(child_board, child_next_mark, child_prev_move)
          child_array << child
        end
      end
    end

    child_array
  end

end
