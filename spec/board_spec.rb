RSpec.describe Minesweeper::Board do
  def count_mines(board)
    board.panel.inject(0) do |sum, row|
      sum + row.count { |tile| tile.mine }
    end
  end

  def calculate_neighbours(tile, board)
    neighbours = 0
    [-1, 0, 1].product([-1, 0, 1]).each do |k, j|
      y = tile.y + k 
      x = tile.x + j
      if y.between?(0, 4) && x.between?(0, 4)
        t = board.panel[y][x]
        neighbours += 1 if t.mine
      end
    end
    neighbours
  end

  def visible_count(board)
    board.panel.inject(0) do |sum, row|
      sum + row.count { |tile| tile.visible }
    end
  end
  
  context "hard board" do
    let(:board) { described_class.new(width: 5, height: 5, difficulty: :hard) }
    let(:difficulty) { described_class::DIFFICULTIES[:hard] }
   
    it "has the right number of mines" do
      board.panel.each { |row| row.map { |tile| tile.visible = true } }
      number_of_mines = ((( 5 * 5 ).to_f / 100.0) * difficulty).to_i
      expect(count_mines(board)).to eq(number_of_mines)
    end

    it "has neighbours calculated correctly" do
      board.panel.each do |row|
        row.each do |tile|
          next if tile.mine
          expect(calculate_neighbours(tile, board)).to eq(tile.neighbours)
        end
      end
    end

    it "has the right amount of visible tiles" do
      expect(visible_count(board)).to eq(described_class::VISIBLE_TILES[:hard])
    end
  end

  context "medium board" do
    let(:board) { described_class.new(width: 5, height: 5, difficulty: :medium) }
    let(:difficulty) { described_class::DIFFICULTIES[:medium] }
    
    it "has the right number of mines" do
      board.panel.each { |row| row.map { |tile| tile.visible = true } }
      number_of_mines = ((( 5 * 5 ).to_f / 100.0) * difficulty).to_i
      expect(count_mines(board)).to eq(number_of_mines)
    end

    it "has neighbours calculated correctly" do
      board.panel.each do |row|
        row.each do |tile|
          next if tile.mine
          expect(calculate_neighbours(tile, board)).to eq(tile.neighbours)
        end
      end
    end

    it "has the right amount of visible tiles" do
      expect(visible_count(board)).to eq(described_class::VISIBLE_TILES[:medium])
    end
  end

  context "easy board" do
    let(:board) { described_class.new(width: 5, height: 5, difficulty: :easy) }
    let(:difficulty) { described_class::DIFFICULTIES[:easy] }
    
    it "has the right number of mines" do
      board.panel.each { |row| row.map { |tile| tile.visible = true } }
      number_of_mines = ((( 5 * 5 ).to_f / 100.0) * difficulty).to_i
      expect(count_mines(board)).to eq(number_of_mines)
    end

    it "has neighbours calculated correctly" do
      board.panel.each do |row|
        row.each do |tile|
          next if tile.mine
          expect(calculate_neighbours(tile, board)).to eq(tile.neighbours)
        end
      end
    end

    it "has the right amount of visible tiles" do
      expect(visible_count(board)).to eq(described_class::VISIBLE_TILES[:easy])
    end
  end

  it "displays the right amount of tiles" do
    board = described_class.new(width: 6, height: 5, difficulty: :medium)
    tiles = board.panel.inject(0) do |sum, row|
      sum + row.length
    end
    expect(tiles).to eq(6 * 5)
  end

  it "displays the right chars" do
    board = described_class.new(width: 10, height: 10, difficulty: :medium)
    board.panel.each do |row|
      row.each do |tile|
        expect(['*', 'X'] + ("0".."9").to_a).to include(tile.to_s)
      end
    end
  end
end
