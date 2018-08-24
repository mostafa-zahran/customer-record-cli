require './data_stores/in_memory/in_memory_interface'

module DataStores
  module InMemory
    module Stores
      # Implementation of user store for in memory data store
      class User
        include DataStores::InMemory::InMemoryInterface

        def initialize(origin_point)
          @origin_point = origin_point
        end

        def add(user)
          storage << user if select { |u| u.id == user.id }.empty?
        end

        def select(&block)
          storage.select(&block)
        end

        def storage
          super[:users] ||= {}
          super[:users][@origin_point] ||= []
        end
      end
    end
  end
end
