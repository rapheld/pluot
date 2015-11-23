require 'faraday'
require 'faraday_middleware'
require 'pluot/oauth'
require 'pluot/proxy'

module Pluot
  class Client
    include Pluot::Proxy

    API_ENDPOINT  = 'https://api.wildapricot.org'
    API_NAMESPACE = '/v2'

    attr_reader :api_key, :account_id, :config

    def initialize(api_key, account_id, config = {})
      @api_key    = api_key
      @account_id = account_id
      @config    = config
    end

    def self.with_global_credentials(config = {})
      self.new(Pluot.api_key, Pluot.account_id, config)
    end

    def get(path)
      connection.get("#{API_NAMESPACE}#{path}").body
    end

    def base
      get('')
    end

    private

    def connection
      Faraday.new(:url => API_ENDPOINT) do |connection|
        connection.request :url_encoded
        connection.headers['Authorization'] = token_header
        connection.response :pluot_parse_json
        connection.adapter :net_http
      end
    end

    def token_header
      "Bearer #{auth_token}"
    end

    def auth_token
      # wild apricot typically gives us an 1800 second token, let's only keep
      # ours for ten minutes
      if @token.nil? or Time.now > (@tokentime + 600)
        @tokentime = Time.now
        @token = Oauth.new(api_key, config).token
      else
        @token
      end
    end

  end
end
