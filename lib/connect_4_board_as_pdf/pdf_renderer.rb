require "prawn" 

module Connect4BoardAsPdf
  class PDFRenderer
    def self.export_board(board, file, config)
      cols = board.get_columns
      rows = board.get_rows

      pdf = Prawn::Document.new(margin: [config[:MARGIN], config[:MARGIN], config[:MARGIN], config[:MARGIN]],
                                page_size: [config[:MARGIN] * 2 + config[:SCALE_FIXED_SIDE_LENGTH] + config[:GRID_SIZE] * cols, config[:MARGIN] * 2 + config[:SCALE_FIXED_SIDE_LENGTH] + config[:GRID_SIZE] * rows])
      pdf.font(config[:FONT_FAMILY])
      pdf.line_width(config[:LINE_WIDTH])

      PDFRenderer.draw_scale_y(pdf, rows, config)
      PDFRenderer.draw_scale_x(pdf, cols, config)
      PDFRenderer.draw_grid(pdf, cols, rows, config)
      PDFRenderer.draw_allocation(pdf, board, cols, rows, config)

      pdf.render_file(file)
    end

    private
    def self.draw_scale_x(pdf, columns, config)
      columns.times do |a|
        text = (a + 65).chr
        pdf.draw_text(text, at: [config[:SCALE_FIXED_SIDE_LENGTH] + a * config[:GRID_SIZE] + (config[:GRID_SIZE] - pdf.width_of(text)) / 2, 0])
      end
    end

    def self.draw_scale_y(pdf, rows, config)
      rows.times do |a|
        pdf.draw_text(a + 1, at: [0, config[:SCALE_FIXED_SIDE_LENGTH] + a * config[:GRID_SIZE] + (config[:GRID_SIZE] - pdf.height_of((a + 1).to_s)) / 2 + config[:Y_SCALE_LABEL_OFFSET]])
      end
    end

    def self.draw_grid(pdf, columns, rows, config)
      width = columns * config[:GRID_SIZE] + config[:SCALE_FIXED_SIDE_LENGTH]
      height = rows * config[:GRID_SIZE] + config[:SCALE_FIXED_SIDE_LENGTH] 

      pdf.stroke_rectangle([config[:SCALE_FIXED_SIDE_LENGTH], height], columns * config[:GRID_SIZE], rows * config[:GRID_SIZE])

      (rows).times do |a|
        y = config[:SCALE_FIXED_SIDE_LENGTH] + (a + 1) * config[:GRID_SIZE]
        pdf.stroke_horizontal_line(config[:SCALE_FIXED_SIDE_LENGTH], width, at: y)
      end

      (columns).times do |a|
        x = config[:SCALE_FIXED_SIDE_LENGTH] + (a + 1) * config[:GRID_SIZE]
        pdf.stroke_vertical_line(config[:SCALE_FIXED_SIDE_LENGTH], height, at: x)
      end
    end

    def self.draw_allocation(pdf, board, columns, rows, config)
      columns.times do |a|
        rows.times do |b|
          column = (a + 64).chr
          row = b + 1
          color = board.get_position(column + row.to_s)

          PDFRenderer.draw_stone(pdf, a, b, color, config) unless color.nil?
        end
      end
    end

    def self.draw_stone(pdf, column, row, color, config)
      x = config[:SCALE_FIXED_SIDE_LENGTH] + column * config[:GRID_SIZE] + config[:GRID_SIZE] / 2.0
      y = config[:SCALE_FIXED_SIDE_LENGTH] + row * config[:GRID_SIZE] + config[:GRID_SIZE] / 2.0
      r = config[:GRID_SIZE] / 2.0 - config[:LINE_WIDTH]

      if color == 'y' 
        pdf.fill_color(config[:COLOR_YELLOW])
        pdf.stroke_color(config[:COLOR_YELLOW])
      end

      if color == 'r'
        pdf.fill_color(config[:COLOR_RED])
        pdf.stroke_color(config[:COLOR_RED])
      end

      pdf.fill_and_stroke_circle([x, y], r)
    end
  end
end