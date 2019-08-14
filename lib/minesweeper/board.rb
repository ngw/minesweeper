module Minesweeper
  class Board
    DIFFICULTIES = {easy: 25, medium: 50, hard: 75}
    VISIBLE_TILES = {easy: 3, medium: 2, hard: 1}

    attr_reader :panel, :width, :height
    
    def initialize(width:, height:, difficulty:)
      @width = width
      @height = height
      @difficulty = difficulty
      populate
    end

    def make_visible!
      @panel.each { |row| row.each { |tile| tile.visible = true } }
    end

    def to_s
      output = ""
      @panel.each do |row|
        row.each do |tile|
          output << tile.to_s
        end
        output << "\n"
      end
      output
    end

    private

    def populate
      @panel = Array.new(@height) do |y|
        Array.new(@width) do |x|
          Tile.new(x: x, y: y)
        end
      end
      mine_panel!
      calculate_all_neighbours!
      set_visibility!
    end

    def area
      @width * @height
    end

    def number_of_mines
      ((area.to_f / 100.0) * DIFFICULTIES[@difficulty]).to_i
    end

    def number_of_visible_tiles
      VISIBLE_TILES[@difficulty]
    end

    def mine_panel!
      count = number_of_mines
      while count != 0
        x, y = rand(@width), rand(@height)
        tile = @panel[y][x]
        unless tile.mine
          tile.mine = true
          count -= 1
        end
      end
    end

    def calculate_all_neighbours!
      @panel.map.with_index do |row, i|
        row.map.with_index do |tile, z|
          next if tile.mine
          tile.neighbours = calculate_neighbours(y: i, x: z)
        end
      end
    end

    def calculate_neighbours(y:, x:)
      count = 0
      [-1, 0, 1].product([-1, 0, 1]).each do |k, j|
        y_index = y + k
        x_index = x + j
        if y_index.between?(0, @height - 1) && x_index.between?(0, @width - 1)
          tile = @panel[y_index][x_index]
          count += 1 if tile.mine == true
        end
      end
      count 
    end

    def set_visibility!
      count = number_of_visible_tiles
      while count != 0
        x, y = rand(@width), rand(@height)
        tile = @panel[y][x]
        unless tile.mine
          tile.visible = true
          count -= 1
        end
      end
    end
  end
end
