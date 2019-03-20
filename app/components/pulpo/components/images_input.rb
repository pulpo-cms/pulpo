module Pulpo
  module Components
    class ImagesInput < Base
      def initialize(env)
        @form = env[:form]
        @has_many_attached = env[:has_many_attached]
        super
      end

      render do |_env, **|
        <<~HTML
          <div data-controller="images-input"
               data-images-input-media-ids="#{ordered_ids.to_json}"
               data-images-input-upload-url="#{main_app.rails_direct_uploads_path}">

            #{file_input}
            #{hidden_input}

            <div class="row" data-target="images-input.imagesContainer"></div>

            <template data-target="images-input.imageTemplate">
              #{image_template}
            </template>
          </div>
        HTML
      end

      private

      attr_reader :form, :has_many_attached

      def main_app
        env[:main_app]
      end

      def ordered_ids
        form.object.send("ordered_#{has_many_attached.to_s.singularize}_ids".to_sym)
      end

      def ordered_blob_ids_attribute
        "ordered_#{has_many_attached}_blob_ids".to_sym
      end

      def file_input
        input = form.file_field(
          :photos,
          class: 'custom-file-input',
          data: {
            target: 'images-input.input',
            action: 'change->images-input#upload'
          }
        )

        <<~HTML
          <div class="form-group">
            <div class="custom-file">
              #{input}
              <label class="custom-file-label" for="validatedCustomFile">Wybierz pliki...</label>
            </div>
          </div>
        HTML
      end

      def hidden_input
        form.hidden_field ordered_blob_ids_attribute, value: ordered_ids.join(','),
                                                      data: { target: 'images-input.mediaIdsInput' }
      end

      def image_template
        <<~HTML
          <div class="col-4 mb-4" data-id="{{ id }}">
            <div class="relative">
              <img src="{{ sizes.medium_s }}" class="rounded">
              <button data-action="images-input#removeImage"
                      data-id="{{ id }}"
                      class="absolute pin-t pin-r m-2 btn btn-danger btn-sm">
                <i class="fa fa-trash"></i>
              </button>
            </div>
          </div>
        HTML
      end
    end
  end
end
