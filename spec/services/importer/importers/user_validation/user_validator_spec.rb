require 'spec_helper'

describe Importer::Importers::UserValidation::UserValidator do
  it 'should be defined' do
    expect(Importer::Importers::UserValidation::UserValidator.class).to eq(Class)
    expect(Importer::Importers::UserValidation::UserValidator.included_modules).to include(Importer::Importers::UserValidation::UserExceptions)
  end

  let!(:valid_hash){{"latitude" => "0.0", "user_id" => 10, "name" => "User 10", "longitude"=> "0.1"}}

  it 'should correctly initialized' do
    validator = Importer::Importers::UserValidation::UserValidator.new(valid_hash)
    expect(validator.instance_variable_get(:@user_hash)).to eq(valid_hash)
    expect(validator.instance_variable_get(:@errors)).to eq([])
  end

  context '#perform' do

    context 'lat is invalid' do
      it 'when lat is empty it should be invalid' do
        empty_lat = {"latitude"=> "", "user_id"=> 10, "name"=> "User 10", "longitude"=> "0.1"}
        validator = Importer::Importers::UserValidation::UserValidator.new(empty_lat)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{empty_lat} has missing latitude")
      end

      it 'when lat is missing it should be invalid' do
        missint_lat = {"user_id"=> 10, "name"=> "User 10", "longitude"=> "0.1"}
        validator = Importer::Importers::UserValidation::UserValidator.new(missint_lat)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{missint_lat} has missing latitude")
      end

      it 'when lat is out of range it should be invalid' do
        out_range_lat = {"latitude"=> "100", "user_id"=> 10, "name"=> "User 10", "longitude"=> "0.1"}
        validator = Importer::Importers::UserValidation::UserValidator.new(out_range_lat)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{out_range_lat} latitude is out of range")
      end
    end

    context 'lng is invalid' do
      it 'when lng is empty it should be invalid' do
        empty_lng = {"latitude"=> "0.1", "user_id"=> 10, "name"=> "User 10", "longitude"=> ""}
        validator = Importer::Importers::UserValidation::UserValidator.new(empty_lng)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{empty_lng} has missing longitude")
      end

      it 'when lng is missing it should be invalid' do
        missint_lng = {"latitude"=> "0.1", "user_id"=> 10, "name"=> "User 10"}
        validator = Importer::Importers::UserValidation::UserValidator.new(missint_lng)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{missint_lng} has missing longitude")
      end

      it 'when lng is out of range it should be invalid' do
        out_range_lng = {"latitude"=> "0.1", "user_id"=> 10, "name"=> "User 10", "longitude"=> "200"}
        validator = Importer::Importers::UserValidation::UserValidator.new(out_range_lng)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{out_range_lng} longitude is out of range")
      end
    end

    context 'name is invalid' do
      it 'when name is empty it should be invalid' do
        empty_name = {"latitude"=> "0.0", "user_id"=> 10, "name"=> "", "longitude"=> "0.1"}
        validator = Importer::Importers::UserValidation::UserValidator.new(empty_name)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{empty_name} has missing name")
      end

      it 'when name is missing it should be invalid' do
        missint_name = {"latitude"=> "0.0", "user_id"=> 10, "longitude"=> "0.1"}
        validator = Importer::Importers::UserValidation::UserValidator.new(missint_name)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{missint_name} has missing name")
      end
    end

    context 'user_id is invalid' do
      it 'when name is empty it should be invalid' do
        empty_id = {"latitude"=> "0.0", "user_id"=> '', "name"=> "User 10", "longitude"=> "0.1"}
        validator = Importer::Importers::UserValidation::UserValidator.new(empty_id)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{empty_id} has missing user_id")
      end

      it 'when name is missing it should be invalid' do
        missint_id = {"latitude"=> "0.0", "name"=> "User 10", "longitude"=> "0.1"}
        validator = Importer::Importers::UserValidation::UserValidator.new(missint_id)
        validator.perform
        expect(validator.valid?).to eq(false)
        expect(validator.errors.size).to eq(1)
        expect(validator.errors.first).to eq("#{missint_id} has missing user_id")
      end
    end

    context 'valid hash' do
      it 'should be valid with empty errors' do
        valid_hash = {"latitude" => "0.0", "user_id" => 10, "name" => "User 10", "longitude"=> "0.1"}
        validator = Importer::Importers::UserValidation::UserValidator.new(valid_hash)
        validator.perform
        expect(validator.valid?).to eq(true)
        expect(validator.errors.size).to eq(0)
      end
    end
  end
end
