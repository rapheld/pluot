require 'faraday'
require 'faraday_middleware'
require 'base64'

module Pluot
  class Oauth

    ENDPOINT   = 'https://oauth.wildapricot.org/auth/token'
    AUTH_SCOPE = [
      :contacts,
      :finances,
      :events,
      :account
    ].join(' ')

    attr_reader :api_key, :auth_scope

    def initialize(api_key, config = {})
      @api_key = api_key
      @auth_scope = config.fetch(:auth_scope, AUTH_SCOPE)
    end

    def token
      connection.post(ENDPOINT, params).body[:access_token]
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
