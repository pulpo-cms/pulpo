module Pulpo
  class UserDecorator < ApplicationDecorator
    def to_s
      object.email
    end
  end
end
