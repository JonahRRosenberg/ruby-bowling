
require_relative '../lib/bowling/game'

describe Bowling::Game do
  it "work for frame one" do
    game = Bowling::Game.new
    game.roll(5)
    game.roll(1)
    game.score.should eq(5 + 1)

    game.complete?.should be_false
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
    game.score.should eq(18 + 8)
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
    game.score.should eq(60)
  end

  it "works with a perfect game" do
    game = Bowling::Game.new
    (1..12).each do |i|
      game.roll(10)
    end
    game.score.should eq(300)

    game.complete?.should be_true
  end

  it "works when last frame is open" do
    game = Bowling::Game.new
    (1..9).each do |i|
      game.roll(0)
      game.roll(0)
    end

    game.complete?.should be_false

    game.roll(5)
    game.roll(3)

    game.score.should eq(8)

    game.complete?.should be_true
  end

  it "works when last frame is spare" do
    game = Bowling::Game.new
    (1..9).each do |i|
      game.roll(0)
      game.roll(0)
    end

    game.roll(2)
    game.roll(8)

    game.roll(7)

    game.score.should eq(17)

    game.complete?.should be_true
  end

  it "works when last frame is strike and 11th is open" do
    game = Bowling::Game.new
    (1..9).each do |i|
      game.roll(0)
      game.roll(0)
    end

    game.roll(10)

    game.roll(1)
    game.roll(7)

    game.score.should eq(18)

    game.complete?.should be_true
  end
  
  it "works when last frame is two strikes, then open" do
    game = Bowling::Game.new
    (1..9).each do |i|
      game.roll(0)
      game.roll(0)
    end

    game.roll(10)
    game.roll(10)

    game.roll(3)

    game.score.should eq(23)

    game.complete?.should be_true
  end

  it "works with example one" do
    game = Bowling::Game.new
    rolls = [ 9, 0, 3, 5, 6, 1, 3, 6, 8, 1, 5, 3, 2, 5, 8, 0, 7, 1, 8, 1 ]
    rolls.each do |roll|
      game.roll(roll)
    end

    game.score.should eq(82)

    scores_by_frame = [9, 17, 24, 33, 42, 50, 57, 65, 73, 82]

    scores_by_frame.each_with_index do |score, index|
      game.score(index+1).should eq(score)
    end

    game.complete?.should be_true
  end
end
