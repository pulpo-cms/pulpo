module Pulpo
  module Components
    class Blankslate < Base
      include InlineSvg::ActionView::Helpers

      # @param title [String] Blankslate heading
      # @param illustration [String, Symbol] Path to or symbol-name of
      #   illustration svg file
      # @param css_classes [Array] Array of classes
      # @param narrow [Boolean] Is this blankslate narrow?
      # @param inline_svg_options [Hash] inline_svg arguments
      def call
        super
      end

      def title
        env[:title] || ''
      end

      def inline_svg_options
        env[:inline_svg_options] || {}
      end

      def css_classes
        env[:css_classes] || []
      end

      def narrow?
        env[:narrow] == true
      end

      def illustration
        ill = env[:illustration]
        return '' if ill.blank?

        if ill.is_a?(Symbol)
          "pulpo/illustrations/#{ill}.svg"
        else
          ill
        end
      end

      render do |&child|
        classes = css_classes
        classes.push('bh-blankslate--narrow') if narrow?
        classes = classes.join(' ')

        <<~HTML
          <div class="bh-blankslate #{classes} %>">
            <div class="row align-items-center">
              <div class="col">
                #{illustration_html}
              </div>

              <div class="bh-blankslate-body col">
                <h2 class="h4">#{title}</h2>

                #{child&.call}
              </div>
            </div>
          </div>
        HTML
      end

      private

      def illustration_html
        inline_svg(
          illustration,
          inline_svg_options.merge(class: 'bh-blankslate-illustration')
        )
      end
    end
  end
end
