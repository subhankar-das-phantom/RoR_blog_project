# In app/controllers/admin/base_controller.rb

class Admin::BaseController < ApplicationController
  # This line will now work correctly because the parent
  # ApplicationController has the authenticate_user! action.
  skip_before_action :authenticate_user!

  # This line ensures only admins can access this section.
  before_action :authenticate_admin!

  layout 'admin'
end
