require 'pulpo/engine'
require 'pulpo/routes'

require 'devise'
require 'pagy'
require 'pundit'
require 'jsonapi-resources'
require 'ransack'
require 'loaf'
require 'draper'
require 'deface'
require 'active_link_to'
require 'inline_svg'
require 'rack/component'

module Pulpo
  class << self
    mattr_accessor :admin_path

    # add default values of more config vars here
    self.admin_path = '/admin'
  end

  # this function maps the vars from your app into your engine
  def self.setup(&block)
    yield self
  end
end
