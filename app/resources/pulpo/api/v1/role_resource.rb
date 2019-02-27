module Pulpo
  module Api
    module V1
      class RoleResource < JSONAPI::Resource
        model_name 'Pulpo::Role'

        attributes :name

        has_many :users
      end
    end
  end
end
