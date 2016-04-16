class UserAuthentication < ActiveRecord::Base
  belongs_to :user
  belongs_to :authentication_provider

  serialize :params

  def self.create_from_omniauth(params, user, provider)
    token_expires_at = params['credentials']['expires_at'] ? Time.at(params['credentials']['expires_at']).to_datetime : nil

    create(
      user: user,
      authentication_provider: provider,
      uid: params['uid'],
      token: params['credentials']['token'],
      token_expires_at: token_expires_at,
      params: params,
    )
  end


  def update_from_omniauth(params)
    token_expires_at = params['credentials']['expires_at'] ? Time.at(params['credentials']['expires_at']).to_datetime : nil

    self.update_attributes(
        uid: params['uid'],
        token: params['credentials']['token'],
        token_expires_at: token_expires_at,
        params: params,
    )
  end

  def provider
    self.authentication_provider.name
  end
end
