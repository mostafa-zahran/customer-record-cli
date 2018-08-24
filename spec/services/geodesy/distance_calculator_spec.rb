require 'spec_helper'

describe Geodesy::DistanceCalculator do
  it 'should be defined' do
    expect(Geodesy::DistanceCalculator.class).to eq(Class)
    expect(Geodesy::DistanceCalculator::EARTH_RADIUS).to eq(6371)
  end

  it 'should initialied correctly' do
    point1 = {lat: rand(100), lng: rand(100)}
    point2 = {lat: rand(100), lng: rand(100)}
    cal_obj = Geodesy::DistanceCalculator.new(point1, point2)
    expect(cal_obj.instance_variable_get(:@point1)).to eq(point1)
    expect(cal_obj.instance_variable_get(:@point2)).to eq(point2)
  end

  context '#distance' do
    before(:all) do
      origin = {lat: 0.0, lng: 0.0}
      lat_unity = {lat: 1.0, lng: 0.0}
      lng_unity = {lat: 0.0, lng: 1.0}
      @known_distances = [
        {point1: origin, point2: origin, distance: 0.0},
        {point1: origin, point2: lat_unity, distance: Geodesy::DistanceCalculator::EARTH_RADIUS},
        {point1: origin, point2: lng_unity, distance: Geodesy::DistanceCalculator::EARTH_RADIUS}
      ]
    end

    def test_known_distance(point1, point2, result)
      expect(Geodesy::DistanceCalculator.new(point1, point2).distance).to eq(result)
    end

    it 'should get same results as known conversions' do
      @known_distances.each{|hash| test_known_distance(hash[:point1], hash[:point2], hash[:distance])}
    end
  end
end
