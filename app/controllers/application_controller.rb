class ApplicationController < ActionController::Base
  include ApplicationHelper
  skip_before_action :verify_authenticity_token

  def auth_required
    redirect_to '/login' unless authenticated?
  end

  def register_auth_required
    redirect_to '/registro/login' unless register_authenticated?
  end
end
