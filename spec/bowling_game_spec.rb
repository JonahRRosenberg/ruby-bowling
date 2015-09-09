
require_relative '../lib/bowling/game'

describe Bowling::Game do
  it "work for frame one" do
    game = Bowling::Game.new
    game.roll(5)
    game.roll(1)
    game.score.should eq(6)
    game.cur_frame.should eq(2)
  end

  it "works with a strike" do
    game = Bowling::Game.new
    game.roll(10)
    game.roll(1)
    game.roll(7)
    game.score.should eq(26)
    game.cur_frame.should eq(2)
  end
end
