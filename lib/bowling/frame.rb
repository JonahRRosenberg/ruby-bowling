module Bowling
  class Frame
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
      if complete?
        (if strike? then @first_roll else @first_roll + @second_roll end)
      else
        nil
      end
    end 

    def complete?
      strike? or (!@first_roll.nil? and !@second_roll.nil?)
    end

    def strike?
      @first_roll == 10
    end

    def spare?
      !strike? and !@first_roll.nil? and raw_score == 10
    end

  end
end
