
require_relative '../lib/bowling/game'

describe Bowling::Game do
  it "work for frame one" do
    game = Bowling::Game.new
    game.roll(5)
    game.roll(1)
    game.score.should eq(5 + 1)
  end

  it "works with a spare and open frame" do
    game = Bowling::Game.new
    game.roll(4)
    game.roll(6)
    game.roll(7)
    game.roll(2)
    game.score.should eq(17 + 9)
  end

  it "works with two spares" do
    game = Bowling::Game.new
    game.roll(4)
    game.roll(6)
    game.roll(7)
    game.roll(3)
    game.roll(2)
    game.score.should eq(17 + 12)
  end

  it "works with a strike" do
    game = Bowling::Game.new
    game.roll(10)
    game.roll(1)
    game.roll(7)
    game.score.should eq(20 + 8)
  end

  it "works with a turkey" do
    game = Bowling::Game.new
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.score.should eq(30)
  end

  it "works with a four-bagger" do
    game = Bowling::Game.new
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.roll(10)
    game.score.should eq(40)
  end
end
