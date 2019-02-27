module Pulpo
  class UserPolicy < ApplicationPolicy
    def index?
      user.role?(:admin)
    end

    def update?
      user.role?(:admin)
    end

    def create?
      user.role?(:admin)
    end
  end
end
