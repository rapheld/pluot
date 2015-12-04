require 'faraday'
require 'faraday_middleware'
require 'base64'

module Pluot
  class Oauth

    class InvalidAuthorization < StandardError
    end
    
    ENDPOINT   = 'https://oauth.wildapricot.org/auth/token'

    # by default we will fetch read-only credentials. for RW,
    # the client must update their config[:auth_type]
    AUTH_SCOPE = [
      :contacts_view,
      :finances_view,
      :events_view,
      :account_view
    ].join(' ')

    attr_reader :api_key, :auth_scope

    def initialize(api_key, config = {})
      @api_key = api_key
      @auth_scope = config.fetch(:auth_scope, AUTH_SCOPE)
    end

    def token
      res = connection.post(ENDPOINT, params)
      token = res.body[:access_token]

      if token.blank?
        raise InvalidAuthorization
      end

      token
    end

    private

    def connection
      Faraday.new(:url => ENDPOINT) do |connection|
        connection.request :url_encoded
        connection.headers['Authorization'] = credentials_header
        connection.response :pluot_parse_json
        connection.adapter :net_http
      end
    end

    def params
      { :grant_type => 'client_credentials', :scope => auth_scope }
    end

    def credentials_header
      "Basic #{credentials}"
    end

    def credentials
      ::Base64.encode64("APIKEY:#{api_key}")
    end

  end
end
