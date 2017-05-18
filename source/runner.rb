require_relative 'sudoku'

board_string = File.readlines('sudoku_puzzles.txt').first.chomp

game = Sudoku.new(board_string)
game.solve
