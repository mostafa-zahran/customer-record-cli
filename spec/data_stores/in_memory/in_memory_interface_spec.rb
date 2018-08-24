require "spec_helper"

describe DataStores::InMemory::InMemoryInterface do

  it 'should be defined' do
    expect(DataStores::InMemory::InMemoryInterface.class).to eq(Module)
  end

  context 'test class behaviour included InMemoryInterface module' do
    let!(:dummy_class) { Class.new { include DataStores::InMemory::InMemoryInterface } }
    let!(:dummy_obj) {dummy_class.new}

    context '#storage' do
      it 'should have storage method' do
        expect(dummy_obj.respond_to?(:storage)).to eq(true)
      end

      it 'should return {} when call it' do
        expect(dummy_obj.storage).to eq({})
      end

      it '$storage is defined and empty' do
        expect($storage).to eq({})
      end
    end

    context '#add' do
      it 'should have add method' do
        expect(dummy_obj.respond_to?(:add)).to eq(true)
      end

      it 'should raise NotImplementedError when call it' do
        expect{dummy_obj.add('')}.to raise_exception(NotImplementedError)
      end
    end

    context '#select' do
      it 'should have select method' do
        expect(dummy_obj.respond_to?(:select)).to eq(true)
      end

      it 'should raise NotImplementedError when call it' do
        expect{dummy_obj.select{}}.to raise_exception(NotImplementedError)
      end
    end
  end
end
