RSpec.describe Minesweeper::Game do
  let(:board) { Minesweeper::Board.new(width: 5, height: 5, difficulty: :easy) }
  let(:game) { Minesweeper::Game.new(board: board) }
  
  it "attempts lucky coordinates" do
    board.panel[1][1].mine = false
    expect(game.attempt(2, 2)).to be_truthy
    expect { game.status }.to output("Still playing\n").to_stdout
  end
  
  it "attempts unlucky coordinatess" do
    board.panel[1][1].mine = true
    expect { game.attempt(2, 2) }.to output("BOOM!!!\n").to_stdout
    expect { game.status }.to output("You lost!\n").to_stdout
  end

  it "attempts invalid coordinates" do
    expect { game.attempt(20, 20) }.to raise_error(StandardError)
  end

  it "displays the board" do
    expect { game.display }.to output(board.to_s).to_stdout
  end
end
