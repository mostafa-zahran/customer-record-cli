require './data_stores/data_store_interface'

module DataStores
  module InMemory
    # InMemoryInterface is interface should be included in any
    # store implemented
    module InMemoryInterface
      include DataStores::DataStoreInterface

      def storage
        $storage ||= {}
      end
    end
  end
end
