require 'yaml'
require 'connect_4_board_as_pdf/connect_4_board'

module Connect4BoardAsPdf
  class Connect4Parser
    def self.load_board_from_yaml(path)
      yaml_poro = YAML.load_file(path)

      self.build_board yaml_poro
    end

    private
    def self.build_board(yaml_poro)
      cols = yaml_poro["meta"]["columns"]
      rows = yaml_poro["meta"]["rows"]

      yellow_positions = yaml_poro["board"]["yellow"]
      red_positions = yaml_poro["board"]["red"]

      board = Connect4Board.new cols, rows

      yellow_positions.each do |pos_str|
        board.set_position pos_str, 'y'
      end

      red_positions.each do |pos_str|
        board.set_position pos_str, 'r'
      end

      board
    end
  end
end