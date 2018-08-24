require "spec_helper"

describe Presenters::User do

  it 'should be defined' do
    expect(Presenters::User.class).to eq(Class)
  end

  let!(:user_obj){Entities::User.new(rand(10), 'User Name', rand(100))}

  context '#initialize' do
    it 'should initialize params correctly' do
      expect(Presenters::User.new(user_obj).instance_variable_get(:@user)).to eq(user_obj)
    end
  end

  context '#perform' do
    it 'should return only id and user_name' do
      expect(Presenters::User.new(user_obj).perform).to eq({
        id: user_obj.id, name: user_obj.user_name
      })
    end
  end
end
