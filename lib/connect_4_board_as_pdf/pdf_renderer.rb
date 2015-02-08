require "prawn" 

module Connect4BoardAsPdf
  class PDFRenderer
    GRID_SIZE = 15
    COLOR_RED = 'ff232e'
    COLOR_YELLOW = 'ffbf00'
    FONT_SIZE = 
    SCALE_FIXED_SIDE_LENGTH = 15
    MARGIN = 5
    FONT_FAMILY = 'Courier'
    LINE_WIDTH = 0.5
    Y_SCALE_LABEL_OFFSET = 2

    def self.export_board(board, file)
      cols = board.get_columns
      rows = board.get_rows

      pdf = Prawn::Document.new margin: [MARGIN, MARGIN, MARGIN, MARGIN],
                                page_size: [MARGIN * 2 + SCALE_FIXED_SIDE_LENGTH + GRID_SIZE * cols, MARGIN * 2 + SCALE_FIXED_SIDE_LENGTH + GRID_SIZE * rows]
      pdf.font FONT_FAMILY
      pdf.line_width LINE_WIDTH

      PDFRenderer.draw_scale_y pdf, rows
      PDFRenderer.draw_scale_x pdf, cols
      PDFRenderer.draw_grid pdf, cols, rows
      PDFRenderer.draw_allocation pdf, board, cols, rows

      pdf.render_file file
    end

    private
    def self.draw_scale_x(pdf, columns)
      columns.times do |a|
        text = (a + 65).chr
        pdf.draw_text text, at: [SCALE_FIXED_SIDE_LENGTH + a * GRID_SIZE + (GRID_SIZE - pdf.width_of(text)) / 2, 0]
      end
    end

    def self.draw_scale_y(pdf, rows)
      rows.times do |a|
        pdf.draw_text a + 1, at: [0, SCALE_FIXED_SIDE_LENGTH + a * GRID_SIZE + (GRID_SIZE - pdf.height_of((a + 1).to_s)) / 2 + Y_SCALE_LABEL_OFFSET]
      end
    end

    def self.draw_grid(pdf, columns, rows)
      width = columns * GRID_SIZE + SCALE_FIXED_SIDE_LENGTH
      height = rows * GRID_SIZE + SCALE_FIXED_SIDE_LENGTH 

      pdf.stroke_rectangle [SCALE_FIXED_SIDE_LENGTH, height], columns * GRID_SIZE, rows * GRID_SIZE

      (rows).times do |a|
        y = SCALE_FIXED_SIDE_LENGTH + (a + 1) * GRID_SIZE
        pdf.stroke_horizontal_line SCALE_FIXED_SIDE_LENGTH, width, at: y
      end

      (columns).times do |a|
        x = SCALE_FIXED_SIDE_LENGTH + (a + 1) * GRID_SIZE
        pdf.stroke_vertical_line SCALE_FIXED_SIDE_LENGTH, height, at: x
      end
    end

    def self.draw_allocation(pdf, board, columns, rows)
      columns.times do |a|
        rows.times do |b|
          column = (a + 64).chr
          row = b + 1
          color = board.get_position column + row.to_s

          PDFRenderer.draw_stone pdf, a, b, color unless color.nil?
        end
      end
    end

    def self.draw_stone(pdf, column, row, color)
      x = SCALE_FIXED_SIDE_LENGTH + column * GRID_SIZE + GRID_SIZE / 2.0
      y = SCALE_FIXED_SIDE_LENGTH + row * GRID_SIZE + GRID_SIZE / 2.0
      r = GRID_SIZE / 2.0 - LINE_WIDTH

      if color == 'y' 
        pdf.fill_color COLOR_YELLOW
        pdf.stroke_color COLOR_YELLOW
      end

      if color == 'r'
        pdf.fill_color COLOR_RED
        pdf.stroke_color COLOR_RED
      end

      pdf.fill_and_stroke_circle [x, y], r
    end
  end
end