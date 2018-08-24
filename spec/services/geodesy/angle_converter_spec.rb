require 'spec_helper'

describe Geodesy::AngleConverter do
  it 'should be defined' do
    expect(Geodesy::AngleConverter.class).to eq(Class)
  end

  it 'should initialied correctly' do
    angle = rand(100)
    converter_obj = Geodesy::AngleConverter.new(angle)
    expect(converter_obj.instance_variable_get(:@angle)).to eq(angle)
  end

  context '#convert_to_radian' do
    before(:all) do
      @known_angles = {
        0 => 0,
        180 => Math::PI,
        360 => 2 * Math::PI
      }
    end

    def test_known_angle(angle, result)
      expect(Geodesy::AngleConverter.new(angle).convert_to_radian).to eq(result)
    end

    it 'should get same results as known conversions' do
      @known_angles.each{|angle, result| test_known_angle(angle, result)}
    end
  end
end
