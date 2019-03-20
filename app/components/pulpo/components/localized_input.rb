module Pulpo
  module Components
    class LocalizedInput < Base
      class DropdownSwitch < Base
        render do |_env, **|
          container_classes = env[:container_classes]

          <<~HTML
            <div class="dropdown #{container_classes}">
              <a href="#" class="dropdown-toggle text-muted" data-toggle="dropdown" data-target="localized-content.currentLocale"></a>

              <div class="dropdown-menu dropdown-menu-right absolute">
                #{render_switches}
              </div>
            </div>
          HTML
        end

        private

        def render_switches
          I18n.available_locales.map { |code| render_switch(code) }.join
        end

        def render_switch(code)
          name = I18n.t("language_names.#{code}")

          <<~HTML
            <a href="#"
               class="dropdown-item"
               data-target="localized-content.switch"
               data-action="localized-content#showSegment"
               data-show-segment-locale="#{code}">#{name}</a>
          HTML
        end
      end

      class Inputs < Base
        render do |env, **|
          type = env[:type].to_sym
          form = env[:form]
          name = env[:name].to_s
          inputs = []

          I18n.available_locales.each do |locale|
            inputs << <<~HTML
              <div class="d-none" data-target="localized-content.segment" data-locale-code="#{locale}">
                #{form.send(type.to_sym, "#{name}_#{locale}".to_sym, class: 'form-control', rows: 5)}
              </div>
            HTML
          end

          inputs.join
        end
      end
    end
  end
end
