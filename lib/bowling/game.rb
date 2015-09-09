require_relative './frame'

module Bowling
  class Game
    def initialize
      @frames = [Frame.new]
    end

    def roll(pins_knocked_down)
      cur_frame.roll(pins_knocked_down)

    end

    def score

    end

    def cur_frame
      @frames[-1]
    end

    def cur_frame_num
      @frames.size
    end

    def is_complete
      false
    end
  end
end

