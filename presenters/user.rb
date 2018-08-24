module Presenters
  # Implemnetation of presentation logic of user entity
  class User
    def initialize(user)
      @user = user
    end

    def perform
      { id: @user.id, name: @user.user_name }
    end
  end
end
