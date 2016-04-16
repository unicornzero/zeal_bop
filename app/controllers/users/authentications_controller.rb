class Users::AuthenticationsController < ApplicationController

  def index
    redirect_to root_url if !current_user
    @apps = current_user.authentications
    @app_providers = {}
    @apps.map do |auth|
      @app_providers[auth.provider] = auth.authentication_provider.id
    end
    @github_handle = ""
    @repo_names = []
    if @app_providers.keys.include?("github")
      gh_token = AuthenticationProvider.find(@app_providers["github"]).user_authentications.first.token
      client = Octokit::Client.new(:access_token => gh_token)
      @gh_username = client.user.login
      @repo_names = client.repositories.map(&:name)
    end

    if @app_providers.keys.include?("agile_central")
      ac_token = AuthenticationProvider.find(@app_providers["agile_central"]).user_authentications.first.token
      client = Wsapi::Session.new(ac_token)
      @ac_username = client.get_current_user.username
      ac_project_data = client.get_projects(fetch: "Name,Workspace,ObjectID")
      p ac_project_data.first
      p_id = ac_project_data.first.id
      emails = client.get_team_members(p_id).first.email
      @ac_proj_names = ac_project_data.map {|p| p.name}
    end
  end

  private


end
