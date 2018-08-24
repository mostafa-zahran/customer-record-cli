require './services/importer/importers/user'

module UseCases
  # Implementation for import users
  class ImportUsers
    def initialize(file_path, origin_point, data_store)
      @file_path = file_path
      @origin_point = origin_point
      @data_store = data_store
    end

    def perform
      Importer::Importers::User.new(@file_path, @origin_point, @data_store)
                               .perform
    end
  end
end
