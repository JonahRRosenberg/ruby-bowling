require_relative './frame'

module Bowling
  class Game
    def initialize
      @frames = []
    end

    def roll(pins_knocked_down)
      if !complete?
        update_frame
        cur_frame.roll(pins_knocked_down)
      end

    end

    def score
      cur_score = 0
      @frames.each_with_index do |frame, index|
        if frame.complete?
          if frame_and_next_are_strikes_and_have_next_frame(frame, index)
            cur_score += frame.raw_score + next_frame(index).raw_score + next_frame(index+2).first_roll
          elsif frame_is_strike_and_next_is_not_strike(frame, index)
            cur_score += frame.raw_score + next_frame(index).raw_score
          elsif frame_is_spare_and_have_next_frame(frame, index)
            cur_score += frame.raw_score + next_frame(index).first_roll
          else
            cur_score += frame.raw_score
          end
        end
      end

      cur_score
    end

    def cur_frame
      @frames[-1]
    end

    def next_frame(index)
      @frames[index+1]
    end

    def next_frame?(index)
      !next_frame(index).nil?
    end

    def update_frame
      if @frames.empty? or cur_frame.complete?
        @frames.push(Frame.new)
      end
    end

    def complete?
      false
    end

    def frame_and_next_are_strikes_and_have_next_frame(frame, index)
      (frame.strike? and
       next_frame?(index) and
       next_frame(index).strike? and
       next_frame?(index+1))
    end

    def frame_is_strike_and_next_is_not_strike(frame, index)
      (frame.strike? and
       next_frame?(index) and
       !next_frame(index).strike?)
    end

    def frame_is_spare_and_have_next_frame(frame, index)
      frame.spare? and !next_frame(index).nil?
    end

  end
end

