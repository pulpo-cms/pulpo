module Pulpo
  class FormSection < Rack::Component
    render do |_env, **, &child|
      <<~HTML
        <div class='form-section row'>
          #{child&.call}
        </div>
      HTML
    end

    class Legend < Rack::Component
      render do |env, **, &child|
        <<~HTML
          <div class='col-4'>
            <h2 class='form-section-title'>#{env[:title]}</h2>

            #{"<div class='form-section-desc'>#{child.call}</div>" if child}
          </div>
        HTML
      end
    end

    class ContentBox < Rack::Component
      render do |_env, **, &child|
        <<~HTML
          <div class="col">
            <div class="card">
              <div class="card-body">
                #{child&.call}
              </div>
            </div>
          </div>
        HTML
      end
    end

    class Separator < Rack::Component
      render do
        <<~HTML
          <hr class='form-section-separator'>
        HTML
      end
    end
  end
end
