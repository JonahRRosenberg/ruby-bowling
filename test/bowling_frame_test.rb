require 'test/unit'
require_relative '../lib/bowling'

class TestBowlingFrame < Test::Unit::TestCase
  def test_frame_one
    frame1 = Bowling::Frame.new
    frame1.roll(5)
    frame1.roll(1)
    assert_equal 6, frame1.game_score
  end
end
