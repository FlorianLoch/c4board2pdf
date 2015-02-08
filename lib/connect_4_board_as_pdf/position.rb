module Connect4BoardAsPdf
  class Position
    def initialize(col, row)
      @col = col
      @row = row
    end

    def get_col
      @col
    end

    def get_row
      @row
    end
  end
end