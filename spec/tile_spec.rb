RSpec.describe Minesweeper::Tile do
  let(:tile) { described_class.new(x: 10, y: 5) }
  
  context "instantiating a new tile" do
    it "accepts x and y but doesn't let you change it" do
      expect(tile.x).to eq(10)
      expect(tile.y).to eq(5)
      expect { tile.x=(10) }.to raise_error(NoMethodError)
      expect { tile.y=(10) }.to raise_error(NoMethodError)
    end

    it "lets you update #mine and #neighbours" do
      tile.mine = true
      tile.neighbours = 10
      expect(tile.mine).to be_truthy
      expect(tile.neighbours).to eq(10)
    end
  end

  context "displaying the tile" do
    it "is not visible" do
      expect(tile.to_s).to eq("X")
    end

    it "is safe" do
      tile.neighbours, tile.visible = 5, true
      expect(tile.to_s).to eq("5")
    end

    it "is mined" do
      tile.mine, tile.visible = true, true
      expect(tile.to_s).to eq("*")
    end
  end
end
