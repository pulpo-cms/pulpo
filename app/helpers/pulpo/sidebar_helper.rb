module Pulpo
  module SidebarHelper
    def sidebar_nav_item(title, uri, opts = {}, &block)
      render(
        layout: 'pulpo/shared/sidebar_nav_item',
        locals: {
          title: title,
          uri: uri,
          opts: opts
        }
      ) do
        capture(&block) if block_given?
      end
    end
  end
end
