require 'connect_4_board_as_pdf/position'

module Connect4BoardAsPdf
  class Connect4Board
    def initialize(columns, rows)
      @columns = columns
      @rows = rows
      @board = Array.new columns do
        Array.new rows
      end
    end

    def get_columns
      @columns
    end

    def get_rows
      @rows
    end

    def set_position(pos_string, color)
      return unless color_valid? color

      pos = Connect4Board.parse_position_string pos_string

      return unless on_board? pos

      @board[pos.get_col][pos.get_row] = color;
      nil
    end

    def get_position(pos_string)
      pos = Connect4Board.parse_position_string pos_string

      @board[pos.get_col][pos.get_row]
    end

    def on_board?(pos)
      pos.get_col < @columns && pos.get_row < @rows
    end

    def color_valid?(color)
      'y' == color || 'r' == color
    end

    private
    def self.parse_position_string(pos_string)
      col = pos_string[0].ord - 65
      row = pos_string[1].to_i - 1

      Position.new col, row
    end
  end
end