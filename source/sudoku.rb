class Sudoku
  def initialize(board_string)
    @board = board_string.split("").each_slice(9).to_a

  end

  def find_single_row(row_index, board_to_check_in = @board)
    board_to_check_in[row_index]
  end

  def find_single_column(col_index, board_to_check_in = @board)
    return_column = []
    board_to_check_in.each {|row| return_column << row[col_index]}
    return_column
  end

  def find_box(row_index, col_index)
    row_array = []
     case row_index
     when (0..2)
      (0..2).each {|index_number| row_array << find_single_row(index_number)}
     when (3..5)
      (3..5).each {|index_number| row_array << find_single_row(index_number)}
     when (6..8)
      (6..8).each {|index_number| row_array << find_single_row(index_number)}
     end
    find_box_columns(col_index, row_array)
  end

  def find_box_columns(col_index, row_array)
    box_array = []
    case col_index
     when (0..2)
      (0..2).each {|index_number| box_array << find_single_column(index_number, row_array)}
     when (3..5)
      (3..5).each {|index_number| box_array << find_single_column(index_number, row_array)}
     when (6..8)
      (6..8).each {|index_number| box_array << find_single_column(index_number, row_array)}
    end
    box_array.flatten
  end

  def check_cell(row_index, column_index)

      if @board[row_index][column_index] == "-"
        check_unique = ["1","2","3","4","5","6","7","8","9"]
        check_unique -= find_single_row(row_index)
        check_unique -= find_single_column(column_index)
        check_unique -= find_box(row_index, column_index)
        if check_unique.length == 1
          # p check_unique
          @board[row_index][column_index] = check_unique.join("")
        else
          @board[row_index][column_index] = "-"
        end
      else
        @board[row_index][column_index] = @board[row_index][column_index]
      end


  end

  def solved?
    @board.flatten.include?("-") == false
  end

  def solve
    until solved?
      @board.map!.with_index do |row, row_index|
        row.map!.with_index do |column, column_index|
          check_cell(row_index, column_index)
        end
      end
    end
    to_s
  end


  def board
  end

  # Returns a nicely formatted string representing the current state of the board
  def to_s
    @board.each {|row| puts row.join("  ")}
  end
end


board_string = File.readlines('sudoku_puzzles.txt').first.chomp

# game = Sudoku.new(board_string)
# game.solve
# puts game

new_game = Sudoku.new(board_string)
# p new_game.check_cell(0,0)
new_game.solve
# p new_game.solved?
