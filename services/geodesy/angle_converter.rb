module Geodesy
  # Implementation for converting angle degrees to radians
  class AngleConverter
    def initialize(angle)
      @angle = angle
    end

    def convert_to_radian
      @angle * Math::PI / 180
    end
  end
end
