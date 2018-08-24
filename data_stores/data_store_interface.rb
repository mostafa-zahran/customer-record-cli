module DataStores
  # DataStoreInterface is interface should be included in any
  # datastore implemented
  module DataStoreInterface
    def storage
      raise NotImplementedError
    end

    def add(_element)
      raise NotImplementedError
    end

    def select(&_block)
      raise NotImplementedError
    end
  end
end
