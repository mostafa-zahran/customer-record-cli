module Geodesy
  # Implementation for distance calculation based on
  # https://en.wikipedia.org/wiki/Great-circle_distance
  class DistanceCalculator
    EARTH_RADIUS = 6371

    def initialize(point1, point2)
      @point1 = point1
      @point2 = point2
    end

    def distance
      @distance ||= EARTH_RADIUS * central_angle
    end

    private

    def central_angle
      2 * Math.asin(Math.sqrt(inner_path))
    end

    def inner_path
      (Math.sin(center_lat)**2) +
        lat1_cos * lat2_cos * (Math.sin(center_lng)**2)
    end

    def center_lat
      (@point1[:lat] - @point2[:lat]).abs / 2
    end

    def center_lng
      (@point1[:lng] - @point2[:lng]).abs / 2
    end

    def lat1_cos
      Math.cos(@point1[:lat])
    end

    def lat2_cos
      Math.cos(@point2[:lat])
    end
  end
end
