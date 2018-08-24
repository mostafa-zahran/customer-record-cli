require 'spec_helper'

describe UseCases::GetCloseUsers do
  it 'should be defined' do
    expect(UseCases::GetCloseUsers.class).to eq(Class)
  end

  before(:all) do
    @max_distance = rand(16)
    @default_data_store = DataStores::InMemory::Stores::User.new(@origin_point)
    @use_case_obj = UseCases::GetCloseUsers.new(@max_distance, @default_data_store)
  end

  it 'can correctly initialize' do
    expect(@use_case_obj.instance_variable_get(:@max_distance)).to eq(@max_distance)
    expect(@use_case_obj.instance_variable_get(:@data_store)).to eq(@default_data_store)
  end

  context '#perform' do
    it 'return empty array when storage is empty' do
      expect(@default_data_store.storage.empty?).to eq(true)
      expect(@use_case_obj.perform).to eq([])
      user_obj = Entities::User.new(rand(1), 'Name', @max_distance)
      @default_data_store.add(user_obj)
      expect(@default_data_store.storage.empty?).to eq(false)
      expect(@use_case_obj.perform).to eq([user_obj])
    end
  end
end
