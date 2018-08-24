require 'spec_helper'

describe Importer::ImporterInterface do
  it 'should be defined' do
    expect(Importer::ImporterInterface.class).to eq(Module)
  end

  context 'test class behaviour included RepositoryInterface module' do

    before(:all) do
      @dummy_class = Class.new { include Importer::ImporterInterface }
      @file_path = './spec/fixtures/test_customers.txt'
      @origin_point = [0.0, 0.0]
      @default_data_store = DataStores::InMemory::Stores::User
      @store_obj = @default_data_store.new(@origin_point)
      @dummy_obj = @dummy_class.new(@file_path, @store_obj)
    end

    it 'should initialized correctly' do
      expect(@dummy_obj.instance_variable_get(:@file_path)).to eq(@file_path)
      expect(@dummy_obj.instance_variable_get(:@data_store)).to eq(@store_obj)
    end

    context '#parse_line' do
      let!(:valid_line){'{"value": "valid text"}'}
      let!(:invalid_line){'{"value": "invalid text'}

      it 'should return json if valid' do
        expect(@dummy_obj.parse_line(valid_line)).to eq(JSON.parse(valid_line))
      end

      it 'should return nil if not valid' do
        expect(@dummy_obj.parse_line(invalid_line)).to eq(nil)
      end
    end

    context '#import' do
      it 'should not store any if no block given' do
        @dummy_obj.import
        expect(@store_obj.select{|_| true}.empty?).to eq(true)
      end

      it 'should run the block if one given' do
        @dummy_obj.import{|hash| Entities::User.new(hash['user_id'].to_i, 'User', 0.0)}
        expect(@store_obj.select{|_| true}.map(&:user_name).uniq).to eq(['User'])
      end
    end
  end
end
