module UseCases
  # Implementation for select required users and sort them
  class GetCloseUsers
    def initialize(max_distance, data_store)
      @max_distance = max_distance
      @data_store = data_store
    end

    def perform
      @data_store
        .select { |user| user.distance <= @max_distance }
        .sort_by(&:distance)
    end
  end
end
