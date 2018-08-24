require './use_cases/import_users'
require './use_cases/get_close_users'
require './data_stores/in_memory/stores/user'
require './presenters/user'

module Runners
  # Implementation of required customer report logic
  class User
    def initialize(file_path, max_distance, origin_point)
      @data_store = DataStores::InMemory::Stores::User.new(origin_point)
      @file_path = file_path
      @max_distance = max_distance.abs
      @origin_point = origin_point
    end

    def perform
      import_users
      present_users(find_users)
    end

    private

    def import_users
      UseCases::ImportUsers.new(@file_path, @origin_point, @data_store).perform
    end

    def find_users
      UseCases::GetCloseUsers.new(@max_distance, @data_store).perform
    end

    def present_users(users)
      users.map { |user| Presenters::User.new(user).perform }
    end
  end
end
