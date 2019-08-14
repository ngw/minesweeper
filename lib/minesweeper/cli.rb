# frozen_string_literal: true

module Minesweeper
  class CLI
    def initialize
      @options = parse
      validate!
    end

    def perform
      board = Board.new(width: @options[:width],
                        height: @options[:height].nil? ? @options[:width] : @options[:height],
                        difficulty: @options[:difficulty])
      game = Game.new(board: board)
      game.perform
    end

    private

    def parse
      options = {}
      OptionParser.new do |opts|
        opts.banner = "Usage: minesweeper [options]"
        opts.on("-w", "--width WIDTH", Integer, "board width WIDTH") do |width|
          options[:width] = width
        end
        opts.on("-h", "--height HEIGHT", Integer, "board height HEIGHT") do |height|
          options[:height] = height
        end
        opts.on("-d", "--difficulty DIFFICULTY", [:easy, :medium, :hard], "difficulty easy|medium|hard") do |difficulty|
          options[:difficulty] = difficulty
        end
      end.parse!
      options
    end

    def validate!
      unless keys_present? && values_present? 
        raise OptionParser::MissingArgument.new(
          "You must provide width and difficulty")
      end
    end

    def keys_present?
      %i[width difficulty].all? { |k| @options.key?(k) }
    end

    def values_present?
      not @options.any? { |k, v| v.nil? }
    end
  end
end
