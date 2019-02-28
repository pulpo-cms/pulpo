module Pulpo
  class Blankslate < Rack::Component
    include InlineSvg::ActionView::Helpers

    def illustration_options
      env[:illustration_options] || {}
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

    def title
      env[:title] || ''
    end

    def illustration_html
      inline_svg(
        illustration,
        illustration_options.merge(class: 'bh-blankslate-illustration')
      )
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
  end
end
