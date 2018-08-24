require "spec_helper"

describe Runners::User do

  it 'should be defined' do
    expect(Runners::User.class).to eq(Class)
  end

  before(:all) do
    @file_path = './spec/fixtures/test_customers.txt'
    @max_distance = rand(16)
    @origin_point = [0.0, 0.0]
    @default_data_store = DataStores::InMemory::Stores::User
  end

  context '#initialize' do
    it 'should initialize params correctly' do
      runner_obj = Runners::User.new(@file_path, @max_distance, @origin_point)
      expect(runner_obj.instance_variable_get(:@file_path)).to eq(@file_path)
      expect(runner_obj.instance_variable_get(:@max_distance)).to eq(@max_distance)
      expect(runner_obj.instance_variable_get(:@origin_point)).to eq(@origin_point)
      expect(runner_obj.instance_variable_get(:@data_store).class).to eq(@default_data_store)
    end
  end

  context '#perform' do
    it 'should return correct sorted results' do
      distance = 10
      result = Runners::User.new(@file_path, distance, @origin_point).perform
      expect(result.size).to eq(8)
      expect(result.map{|r| r[:id]}).to eq((1..result.size).to_a)
      expect(result.first.keys).to eq([:id, :name])
    end

    context 'distance change' do
      it 'should get all customer when distance is the max' do
        result = Runners::User.new(@file_path, 16, @origin_point).perform
        expect(result.size).to eq(10)
      end

      it 'should get no customer when distance is 0' do
        result = Runners::User.new(@file_path, 0, @origin_point).perform
        expect(result.size).to eq(0)
      end
    end

    context 'distance origin' do
      it 'should get 1 customer when origin is same as customer position with 0 distance' do
        origin_point = [0.0, 0.1]
        result = Runners::User.new(@file_path, 0.0, origin_point).perform
        expect(result.size).to eq(1)
      end

      it 'should get no customer when origin is far away' do
        origin_point = [10.0, 10.0]
        result = Runners::User.new(@file_path, @max_distance, origin_point).perform
        expect(result.size).to eq(0)
      end
    end
  end
end
