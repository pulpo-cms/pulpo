module Pulpo
  module Sortable
    extend ActiveSupport::Concern

    included do
      scope :by_position, -> { order(position: :asc) }
    end
  end
end
