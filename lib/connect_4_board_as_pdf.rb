require "connect_4_board_as_pdf/connect_4_parser"
require 'connect_4_board_as_pdf/pdf_renderer'

module Connect4BoardAsPdf
  class MainProcessor
    DEFAULT_CONFIG_FILE_NAME = 'c4board2pdf.conf.yaml'

    def initialize(config_file_name)
      @config_file_name = config_file_name
      @config_file_name ||= DEFAULT_CONFIG_FILE_NAME

      @config = {
        GRID_SIZE: 15,
        COLOR_RED: 'ff232e',
        COLOR_YELLOW: 'ffd80d',
        FONT_SIZE: 12,
        SCALE_FIXED_SIDE_LENGTH: 15,
        MARGIN: 5,
        FONT_FAMILY: 'Courier',
        LINE_WIDTH: 0.5,
        LINE_COLOR: "595659",
        Y_SCALE_LABEL_OFFSET: 2      
      }

      load_config
    end

    def process_file(file, outputFile)
      board = Connect4Parser.load_board_from_yaml(file)

      PDFRenderer.export_board(board, outputFile, @config)
    end

    private 
    def load_config()
      path = File.join(Dir.pwd, @config_file_name)

      return unless File.exists?(path)

      config = YAML.load_file(path);

      @config.each_key do |key|
        next if config[key.to_s].nil?

        @config[key] = config[key.to_s]
      end
    end
  end
end
