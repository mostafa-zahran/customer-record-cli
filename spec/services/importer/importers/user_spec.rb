require 'spec_helper'

describe Importer::Importers::User do
  it 'should be defined' do
    expect(Importer::Importers::User.class).to eq(Class)
    expect(Importer::Importers::User.included_modules).to include(Importer::ImporterInterface)
  end

  before(:all) do
    @file_path = './spec/fixtures/test_customers.txt'
    @origin_point = [rand(10).to_f, rand(10).to_f]
    @store_obj = DataStores::InMemory::Stores::User.new(@origin_point)
    @user_importer_obj = Importer::Importers::User.new(@file_path, @origin_point, @store_obj)
  end

  it 'should intialized correctly' do
    expect(@user_importer_obj.instance_variable_get(:@file_path)).to eq(@file_path)
    expect(@user_importer_obj.instance_variable_get(:@data_store)).to eq(@store_obj)
    point = {
      lat: Geodesy::AngleConverter.new(@origin_point[0]).convert_to_radian,
      lng:Geodesy::AngleConverter.new(@origin_point[1]).convert_to_radian
    }
    expect(@user_importer_obj.instance_variable_get(:@origin_point)).to eq(point)
  end

  context '#perform' do
    it 'should import all users from customer_file and wrap it in user objs' do
      @user_importer_obj.perform
      all_users = @store_obj.select{|_| true}
      expect(all_users.size).to eq(10)
      expect(all_users.map(&:class).uniq).to eq([Entities::User])
      expect(all_users.map(&:distance).uniq).to_not eq([nil])
    end
  end
end
