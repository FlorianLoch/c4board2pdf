require "connect_4_board_as_pdf/connect_4_parser"
require 'connect_4_board_as_pdf/pdf_renderer'

module Connect4BoardAsPdf
  def process_file(file, outputFile)
    board = Connect4Parser.load_board_from_yaml(file)

    PDFRenderer.export_board(board, outputFile)
  end

  module_function :process_file
end
