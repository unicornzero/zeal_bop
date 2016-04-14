class Users::AuthenticationsController < ApplicationController

  def index
    redirect_to root_url if !current_user
    @apps = current_user.authentications
    @app_providers = @apps.map { |auth| auth.authentication_provider.name }
  end
end
