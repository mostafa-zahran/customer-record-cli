require 'spec_helper'

describe UseCases::ImportUsers do
  it 'should be defined' do
    expect(UseCases::ImportUsers.class).to eq(Class)
  end

  before(:all) do
    @file_path = './spec/fixtures/test_customers.txt'
    @origin_point = [-1.0, -1.0]
    @default_data_store = DataStores::InMemory::Stores::User.new(@origin_point)
    @use_case_obj = UseCases::ImportUsers.new(@file_path, @origin_point, @default_data_store)
  end

  it 'can correctly initialize' do
    expect(@use_case_obj.instance_variable_get(:@file_path)).to eq(@file_path)
    expect(@use_case_obj.instance_variable_get(:@origin_point)).to eq(@origin_point)
    expect(@use_case_obj.instance_variable_get(:@data_store)).to eq(@default_data_store)
  end

  context '#perform' do
    it 'can actually import' do
      expect(@default_data_store.storage.empty?).to eq(true)
      @use_case_obj.perform
      expect(@default_data_store.storage.empty?).to eq(false)
    end
  end
end
