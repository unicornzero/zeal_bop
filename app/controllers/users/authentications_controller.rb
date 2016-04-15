class Users::AuthenticationsController < ApplicationController

  def index
    redirect_to root_url if !current_user
    @apps = current_user.authentications
    @app_providers = {}
    @apps.map do |auth|
      @app_providers[auth.authentication_provider.name] = auth.authentication_provider.id
    end
    @github_handle = ""
    @repo_names = []
    if @app_providers.keys.include?("github")
      gh_token = AuthenticationProvider.find(@app_providers["github"]).user_authentications.first.token
      client = Octokit::Client.new(:access_token => gh_token)
      @github_handle = client.user.login
      @repo_names = client.repositories.map(&:name)
    end
  end

end
