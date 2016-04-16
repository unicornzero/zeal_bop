require "omniauth/strategies/oauth2"
require "wsapi/session"

module OmniAuth
  module Strategies
    class AgileCentral < OmniAuth::Strategies::OAuth2
      ZUUL_URL = ENV["ZUUL_URL"] || ""
      puts "ZuulURL is #{ZUUL_URL}"
      option :name, "agile_central"
      option :authorize_options, [:state, :scope]
      option :client_options, authorize_url: File.join(ZUUL_URL, "/login/oauth2/auth"),
             token_url: File.join(ZUUL_URL, "/login/oauth2/token")

      option :provider_ignores_state, false
      option :scope, "alm"

      uid { alm_user.id.to_s }

      info do
        {
            username: alm_user.username,
            first_name: alm_user.first_name,
            last_name: alm_user.last_name,
            email: alm_user.email
        }
      end

      credentials do
        { redirect_uri: callback_url }
      end

      extra do
        {
            subscription_id: alm_subscription.subscription_id
        }
      end

      def callback_phase
        begin
          puts "calling back phase"
          super
          puts "did super"
            # rescue Wsapi::IpAddressLimited => e
            #   fail! :ip_address_limited, e
        rescue => e
          p e
          puts "something went wrong with CAAC"
           #   byebug
         end
      end

      def token_params
        super.merge(headers: { "Authorization" => "Basic #{authorization_header}" })
      end

      def authorization_header
        value = Base64.encode64([options.client_id, options.client_secret].join(":"))
        value.gsub!("\n", "")
      end

      def alm_user
        @alm_user ||= wsapi_session.get_current_user
      end

      def alm_subscription
        @alm_subscription ||= wsapi_session.get_user_subscription
      end

      def wsapi_session
        @wsapi_session ||= Wsapi::Session.new(access_token.token, version: "2.0")
      end
    end
  end
end
