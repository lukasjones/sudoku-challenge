class Sudoku
  def initialize(board_string)
    @board = board_string.split("").each_slice(9).to_a
  end

  def find_single_row(row_index)
    @board[row_index]
  end

  def find_single_column(col_index, board_to_check_in = @board)
    board_to_check_in.map {|row| row[col_index]}
  end

  def find_box(row_index, col_index)
    row_array = []

    find_row = Proc.new {|index_number| row_array << find_single_row(index_number)}

    case row_index
    when (0..2)
      (0..2).each(&find_row)
    when (3..5)
      (3..5).each(&find_row)
    when (6..8)
      (6..8).each(&find_row)
    end

    find_box_columns(col_index, row_array)
  end

  def find_box_columns(col_index, row_array)
    box_array = []

    find_col = Proc.new {|index_number| box_array << find_single_column(index_number, row_array)}

    case col_index
     when (0..2)
      (0..2).each(&find_col)
     when (3..5)
      (3..5).each(&find_col)
     when (6..8)
      (6..8).each(&find_col)
    end

    box_array.flatten
  end

  def check_cell(row_index, column_index)
    cell = @board[row_index][column_index]

    if cell == "-"
      check_unique = ["1","2","3","4","5","6","7","8","9"]
      check_unique -= find_single_row(row_index)
      check_unique -= find_single_column(column_index)
      check_unique -= find_box(row_index, column_index)

      cell = check_unique[0] if check_unique.length == 1
    end

    cell
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

  def to_s
    @board.each {|row| puts row.join("  ")}
  end
end
