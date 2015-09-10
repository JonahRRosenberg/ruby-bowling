require_relative '../lib/bowling/frame'

describe Bowling::Frame do
  it "works with no rolls" do
    frame = Bowling::Frame.new

    frame.open?.should be_false
    frame.strike?.should be_false
    frame.spare?.should be_false
    frame.raw_score.should eq(0)
  end

  it "works with one roll" do
    frame = Bowling::Frame.new

    frame.roll(5)

    frame.open?.should be_false
    frame.strike?.should be_false
    frame.spare?.should be_false
    frame.raw_score.should eq(5)
  end

  it "works for open frame 9" do
    frame = Bowling::Frame.new

    frame.roll(5)
    frame.roll(4)

    frame.open?.should be_true
    frame.strike?.should be_false
    frame.spare?.should be_false
    frame.raw_score.should eq(9)
  end

  it "works for open frame with zero" do
    frame = Bowling::Frame.new

    frame.roll(0)
    frame.roll(1)

    frame.open?.should be_true
    frame.strike?.should be_false
    frame.spare?.should be_false
    frame.raw_score.should eq(1)
  end

  it "works for strike" do
    frame = Bowling::Frame.new

    frame.roll(10)

    frame.open?.should be_false
    frame.strike?.should be_true
    frame.spare?.should be_false

    frame.raw_score.should eq(10)
  end

  it "works for spare" do
    frame = Bowling::Frame.new

    frame.roll(9)
    frame.roll(1)

    frame.open?.should be_false
    frame.strike?.should be_false
    frame.spare?.should be_true

    frame.raw_score.should eq(10)
  end

  it "works for zeros" do
    frame = Bowling::Frame.new

    frame.roll(0)
    frame.roll(0)

    frame.open?.should be_true
    frame.strike?.should be_false
    frame.spare?.should be_false

    frame.raw_score.should eq(0)
  end

end

