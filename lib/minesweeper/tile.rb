module Minesweeper
  class Tile
    attr_reader :x, :y
    attr_accessor :mine, :neighbours, :visible

    def initialize(x:, y:)
      @x = x
      @y = y
      @mine = false
      @neighbours = 0
      @visible = false
    end

    def to_s
      if @visible
        @mine ? "*" : @neighbours.to_s
      else
        "X"
      end
    end
  end
end

