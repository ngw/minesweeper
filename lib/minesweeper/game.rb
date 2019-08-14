module Minesweeper
  class Game
    def initialize(board:)
      @board = board
      @status = :in_progress
    end

    def perform
      puts <<~HELP
      COMMANDS: display
                attempt(x, y)
                too_much_stress_i_give_up
                status
      HELP
      binding.pry
    end

    def display
      puts @board
    end

    def attempt(x, y)
      validate_coords(x: x, y: y)
      tile = @board.panel[y - 1][x - 1]
      if tile.mine
        too_much_stress_i_give_up
      else
        tile.visible = true
      end
    end

    def status
      case @status
      when :in_progress
        puts "Still playing"
      when :lost
        puts "You lost!"
      end
      @status
    end

    def too_much_stress_i_give_up
      @status = :lost
      @board.make_visible!
      puts "BOOM!!!"
    end

    private

    def validate_coords(x:, y:)
      if !(x - 1).between?(0, @board.width - 1) || !(y - 1).between?(0, @board.height - 1)
        raise StandardError, "Invalid coordinates"
      end
    end
  end
end
