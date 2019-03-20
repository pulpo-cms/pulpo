module Pulpo
  module Api
    module V1
      class MediumResource < JSONAPI::Resource
        model_name 'ActiveStorage::Blob'

        attributes :created_at

        attribute :filename
        attribute :sizes

        def filename
          @model.filename.to_s
        end

        def sizes
          {
            # @todo this doesn't seem to be a proper way of generating AS urls
            original: '/rails' + Rails.application.routes.url_helpers.rails_blob_path(@model, host: ''),
            medium_s: Rails.application.routes.url_helpers.rails_representation_url(
              @model.variant(combine_options: { auto_orient: true, gravity: 'center', resize: '400x400<', crop: '400x400+0+0' }).processed, only_path: true
            )
          }
        end

        def self.sortable_fields(context)
          super(context) + [:position]
        end

        def self.apply_sort(records, order_options, context = {})
          if order_options.key?('position')
            records = records.joins(:attachments).order('active_storage_attachments.position ASC')
            order_options.delete('position')
          end

          super(records, order_options, context)
        end
      end
    end
  end
end
