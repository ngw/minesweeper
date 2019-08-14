RSpec.describe Minesweeper::CLI do
  it "expects arguments" do
    expect {described_class.new }.to raise_error(OptionParser::MissingArgument)
    stub_const('ARGV', %w(--width 12))
    expect {described_class.new }.to raise_error(OptionParser::MissingArgument)
    stub_const('ARGV', %w(--height 12 --difficulty medium))
    expect {described_class.new }.to raise_error(OptionParser::MissingArgument)
  end

  context 'starting a game' do
    let(:board) { double(:board) }
    let(:game) { double(:game) }

    it "uses its arguments" do
      expect(Minesweeper::Board).to receive(:new).with(width: 12, height: 12, difficulty: :easy).and_return(board)
      expect(Minesweeper::Game).to receive(:new).with(board: board).and_return(game)
      allow(game).to receive(:perform)
      stub_const('ARGV', %w(--width 12 --height 12 --difficulty easy))
      cli = described_class.new
      cli.perform
    end

    it "handles squares" do
      expect(Minesweeper::Board).to receive(:new).with(width: 12, height: 12, difficulty: :easy).and_return(board)
      expect(Minesweeper::Game).to receive(:new).with(board: board).and_return(game)
      allow(game).to receive(:perform)
      stub_const('ARGV', %w(--width 12 --difficulty easy))
      cli = described_class.new
      cli.perform
    end
  end
end
