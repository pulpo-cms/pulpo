module Pulpo
  class Engine < ::Rails::Engine
    isolate_namespace Pulpo

    # sets the manifests / assets to be precompiled, even when initialize_on_precompile is false
    # initializer 'pulpo.assets.precompile', group: :all do |app|
    #   app.config.assets.precompile += %w[
    #     pulpo/all*
    #   ]
    # end

    initializer 'pulpo.environment', before: :load_config_initializers do
      Pulpo::Config = Pulpo::AppConfiguration.new
    end

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_bot, dir: 'spec/factories'
    end

    config.to_prepare do
      Devise::SessionsController.layout 'pulpo/devise'
    end
  end
end
