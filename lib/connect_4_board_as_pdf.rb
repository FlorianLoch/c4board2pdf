require "connect_4_board_as_pdf/connect_4_parser"
require 'connect_4_board_as_pdf/pdf_renderer'

module Connect4BoardAsPdf
  class MainProcessor
    DEFAULT_CONFIG_FILE_NAME = 'c4board2pdf.conf.yaml'
    @config_file_name
    @config = {

    }

    def initialize(config_file_name)
      @config_file_name = config_file_name
      @config_file_name ||= DEFAULT_CONFIG_FILE_NAME

      load_config
    end

    def process_file(file, outputFile)
      board = Connect4Parser.load_board_from_yaml(file)

      PDFRenderer.export_board(board, outputFile, @config)
    end

    private 
    def load_config()
      return unless File.exists?(@config_file_name)

    end
  end
end
