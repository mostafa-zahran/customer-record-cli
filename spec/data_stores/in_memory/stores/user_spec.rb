require "spec_helper"

describe DataStores::InMemory::Stores::User do

  context 'definiation' do
    it 'should be defined' do
      expect(DataStores::InMemory::Stores::User.class).to eq(Class)
    end
    it 'should include InMemoryInterface' do
      expect(DataStores::InMemory::Stores::User.included_modules).to include(DataStores::InMemory::InMemoryInterface)
    end
  end

  context 'DataStores::InMemory::Stores::User behaviour' do
    let!(:origin_point) {[0.0, 0.0]}
    let!(:repo_obj) {DataStores::InMemory::Stores::User.new(origin_point)}

    before(:all) do
      @user_obj = Entities::User.new(rand(10), 'User Name', rand(100))
    end

    context '#storage' do
      it 'should return users storage when call it' do
        expect(repo_obj.storage).to eq([])
      end

      it '$storage is defined and has initial users storage' do
        expect($storage).to eq({users: {origin_point => []}})
      end
    end

    context '#add' do
      it 'can add user object to $storage' do
        repo_obj.add(@user_obj)
        expect($storage[:users][origin_point]).to eq(Array(@user_obj))
      end

      it 'will not add the same object twice' do
        repo_obj.add(@user_obj)
        repo_obj.add(@user_obj)
        expect($storage[:users][origin_point].size).to eq(1)
      end
    end

    context '#select' do
      it 'can select user object' do
        result = repo_obj.select{|user| user.id == @user_obj.id }.first
        expect(result.class).to eq(Entities::User)
        expect(result.object_id).to eq(@user_obj.object_id)
        expect(result.user_name).to eq(@user_obj.user_name)
        expect(result.distance).to eq(@user_obj.distance)
      end

      it 'can NOT select user object' do
        expect(repo_obj.select{|user| user.id == @user_obj.id + 1}).to eq([])
      end
    end
  end
end
