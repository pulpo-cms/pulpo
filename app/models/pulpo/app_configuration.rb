module Pulpo
  class AppConfiguration < Preferences::Configuration
    preference :site_title, :string, default: 'Pulpo'
    preference :site_description, :string, default: 'Powered by Pulpo CMS'
  end
end
