require_relative './frame'

module Bowling
  class Game
    NUM_FRAMES = 10

    def initialize
      @frames = []
    end

    def roll(pins_knocked_down)
      if !complete?
        update_frame
        cur_frame.roll(pins_knocked_down)
      end

    end

    def score(through_frame=[@frames.size, NUM_FRAMES].min)
      cur_score = 0
      (0..(through_frame-1)).each do |index|
        frame = cur_frame(index)
        if frame_and_next_are_strikes_and_have_next_frame(index)
          cur_score += frame.raw_score + next_frame(index).raw_score + next_frame(index+1).first_roll
        elsif frame_is_strike_and_next_is_not_strike(index)
          cur_score += frame.raw_score + next_frame(index).raw_score
        elsif frame_is_spare_and_have_next_frame(index)
          cur_score += frame.raw_score + next_frame(index).first_roll
        elsif frame.open?
          cur_score += frame.raw_score
        end
      end

      cur_score
    end

    def cur_frame(index=-1)
      @frames[index]
    end

    def next_frame(index)
      @frames[index+1]
    end

    def next_frame?(index)
      !next_frame(index).nil?
    end

    def update_frame
      if @frames.empty? or cur_frame.strike? or cur_frame.spare? or cur_frame.open?
        @frames.push(Frame.new)
      end
    end

    def complete?
      tenth_frame_is_open or
      tenth_frame_is_spare_and_eleventh_is_single_roll or
      tenth_frame_is_strike_and_eleventh_is_open or
      tenth_frame_is_strike_and_eleventh_is_strike_and_twelth_is_single_roll
    end

    def frame_and_next_are_strikes_and_have_next_frame(index)
      (cur_frame(index).strike? and
       next_frame?(index) and
       next_frame(index).strike? and
       next_frame?(index+1))
    end

    def frame_is_strike_and_next_is_not_strike(index)
      (cur_frame(index).strike? and
       next_frame?(index) and
       !next_frame(index).strike?)
    end

    def frame_is_spare_and_have_next_frame(index)
      cur_frame(index).spare? and !next_frame(index).nil?
    end

    def tenth_frame_is_open
      @frames.size == NUM_FRAMES and @frames[NUM_FRAMES-1].open?
    end

    def tenth_frame_is_spare_and_eleventh_is_single_roll
      (@frames.size == NUM_FRAMES+1 and
       @frames[NUM_FRAMES-1].spare? and
       !@frames[NUM_FRAMES].first_roll.nil?)
    end

    def tenth_frame_is_strike_and_eleventh_is_open
      (@frames.size == NUM_FRAMES+1 and
       @frames[NUM_FRAMES-1].strike? and
       @frames[NUM_FRAMES].open?)
    end

    def tenth_frame_is_strike_and_eleventh_is_strike_and_twelth_is_single_roll
      (@frames.size == NUM_FRAMES+2 and
       @frames[NUM_FRAMES-1].strike? and
       @frames[NUM_FRAMES].strike? and
       !@frames[NUM_FRAMES+1].first_roll.nil?)
    end

  end
end

