module Entities
  # Impelemntation for user entity
  class User
    attr_reader :id, :user_name, :distance

    def initialize(id, user_name, distance)
      @id = id
      @user_name = user_name
      @distance = distance
    end
  end
end
