module Bowling
  class Frame
    attr_reader :first_roll
    attr_reader :second_roll

    def initialize
      @first_roll = nil
      @second_roll = nil
    end

    def roll(pins_knocked_down)
      if @first_roll.nil?
        @first_roll = pins_knocked_down
      elsif @second_roll.nil?
        @second_roll = pins_knocked_down
      end
    end

    def raw_score
      score = 0
      if !@first_roll.nil?
        score += @first_roll
      end
      if !@second_roll.nil?
        score += @second_roll
      end
      score
    end 

    def open?
      !strike? and !spare? and !@first_roll.nil? and !@second_roll.nil?
    end

    def strike?
      @first_roll == 10
    end

    def spare?
      !strike? and !@first_roll.nil? and raw_score == 10
    end

  end
end
