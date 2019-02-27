module Pulpo
  module Admin
    class BaseController < ApplicationController
      include Pagy::Backend

      before_action :authenticate_user!

      breadcrumb 'Home', :admin_root_path
    end
  end
end
