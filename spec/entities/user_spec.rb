require "spec_helper"
require 'securerandom'

describe Entities::User do

  it 'should be defined' do
    expect(Entities::User.class).to eq(Class)
  end

  before(:all) do
    @user_id = rand(10)
    @user_name = SecureRandom.urlsafe_base64(4).tr('-', '_')
    @distance = rand(100)
    @user_obj = Entities::User.new(@user_id, @user_name, @distance)
  end

  context 'test ability to read correctly by not write attributes' do
    def entity_define_method(method_name)
      expect(@user_obj.respond_to?(method_name)).to eq(true)
    end

    def entity_not_define_method(method_name)
      expect(@user_obj.respond_to?(method_name)).to_not eq(true)
    end

    context '#id' do
      it 'should read id' do
        entity_define_method(:id)
        expect(@user_obj.id).to eq(@user_id)
      end

      it 'should not write id' do
        entity_not_define_method(:id=)
      end
    end

    context '#user_name' do
      it 'should read user_name' do
        entity_define_method(:user_name)
        expect(@user_obj.user_name).to eq(@user_name)
      end

      it 'should not write user_name' do
        entity_not_define_method(:user_name=)
      end
    end

    context '#distance' do
      it 'should read distance' do
        entity_define_method(:distance)
        expect(@user_obj.distance).to eq(@distance)
      end

      it 'should not write distance' do
        entity_not_define_method(:distance=)
      end
    end
  end
end
