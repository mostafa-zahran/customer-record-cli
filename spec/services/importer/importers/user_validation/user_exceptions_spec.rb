require "spec_helper"

describe Importer::Importers::UserValidation::UserExceptions do

  it 'should be defined' do
    expect(Importer::Importers::UserValidation::UserExceptions.class).to eq(Module)
  end

  context 'test included classes' do

    def test_exception_class(class_name)
      expect(class_name.class).to eq(Class)
      expect(class_name.superclass).to eq(RuntimeError)
    end

    it 'UrlNotPresent is defined and inherte from RuntimeError' do
      test_exception_class(Importer::Importers::UserValidation::UserExceptions::MissingLat)
    end

    it 'ShortCodeBadFormat is defined and inherte from RuntimeError' do
      test_exception_class(Importer::Importers::UserValidation::UserExceptions::MissingLng)
    end

    it 'ShortCodeInUse is defined and inherte from RuntimeError' do
      test_exception_class(Importer::Importers::UserValidation::UserExceptions::MissingId)
    end

    it 'ShortyException is defined and inherte from RuntimeError' do
      test_exception_class(Importer::Importers::UserValidation::UserExceptions::MissingName)
    end

    it 'ShortyException is defined and inherte from RuntimeError' do
      test_exception_class(Importer::Importers::UserValidation::UserExceptions::LatOutOFRange)
    end

    it 'ShortyException is defined and inherte from RuntimeError' do
      test_exception_class(Importer::Importers::UserValidation::UserExceptions::LngOutOfRange)
    end
  end
end
